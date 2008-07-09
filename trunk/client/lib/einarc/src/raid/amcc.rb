#
# vim: ai noexpandtab

module RAID
	class Amcc < BaseRaid
		TWCLI = "#{$EINARC_LIB}/amcc/cli"

		def initialize(adapter_num = nil)
			@adapter_num = adapter_num
		end

		# ======================================================================

		def self.query(res)
			run(" info").each { |l|
				if l =~ /^c[0-9]+/ then
					x=l.split(/ +/)
					version=""
					run("/#{x[0]} show firmware").each{ |f|
						if f =~ /Firmware Version/ then
							version=f.split(/ +/)[-1]
						end
					}
					res << {
						:driver => 'amcc',
						:num => x[0][1..-1],
						:model => x[1],
						:version => version,
					}
				end
			}
			raise Error.new('amcc: failed to query adapter list') if $?.exitstatus != 0
			return res
		end

		# ======================================================================

		def _adapter_info
			res = {}
			run(" show all").each {|l|
			if l =~ /^\/c[0-9]+/ then
				key, value = l.split(/ = /)
				key.slice!(/^\/c[0-9]+ /)
				key=case key
					when 'Serial Number' then 'Serial number'
					when 'Firmware Version' then 'Firmware version'
					else key
				end
				res[key]=value
			end
			}
			# as per http://www.3ware.com/KB/article.aspx?id=15127
			# and http://pci-ids.ucw.cz/iii/?i=13c1
			res['PCI vendor ID'] = '13c1'
			res['PCI product ID'] = case res['Model']
				when /^9690/ then '1005'
				when /^9650/ then '1004'
				when /^9550/ then '1003'
				when /^9/ then '1002'
				when /^[78]/ then '1001'
			end
			return res
		end

		def adapter_restart
			raise NotImplementedError
		end

		# ======================================================================

		def _task_list
			res = []
			return res
		end

		# ======================================================================

		def log_clear
		end

		def _log_list
			[]
		end

		# ======================================================================

		def _logical_list
			# FIXME: spares?
			@logical = []
			mapping={} # between units and ports

			run(" show").each { |l|
				case l
	# Unit  UnitType  Status         %RCmpl  %V/I/M  Stripe  Size(GB)  Cache  AVrfy
	# ------------------------------------------------------------------------------
	# u0    RAID-1    OK             -       -       -       465.651   ON     OFF    
	# u1    RAID-5    OK             -       -       64K     931.303   ON     OFF    
	# u2    RAID-5    OK             -       -       64K     931.303   ON     OFF    
				when /^u([0-9]+) +(\S+) +(\S+) +(\S+) +(\S+) +(\S+) +([0-9\.]+) +(\S)/
					logical << {
						:num => $1,
# FIXME provide Linux device (from sysfs? smartctl?)
#						:dev => nil,
						:physical => [],
						:state => case $3
							when "OK" then "normal"
							when /REBUILD/ then "rebuilding"
							when /INITIALIZING/ then "initializing"
							else $3
							end,
						:raid_level => $2,
						# remove trailing 'K'
						:stripe => case $6 
							when "-" then nil
							else $6[1..-1]
							end,
						# 3ware reports in GiB, einarc in MiB
						:capacity => 1024*($7.to_f),
						:cache => case $8
							when "ON" then "writeback"
							else "writethrough"
							end,
					}
					mapping[$1]=[]
					# ports come later in the output, that's why
					# we have some 'mapping' magic here
					# also, unit numbers are NOT contiguous
	# Port   Status           Unit   Size        Blocks        Serial
	# ---------------------------------------------------------------
	# p0     OK               u0     465.76 GB   976773168     WD-WCASU1168570     
	# p1     OK               u0     465.76 GB   976773168     WD-WCASU1168141     
	# p2     OK               u1     465.76 GB   976773168     WD-WCASU1168002     
	# p3     OK               u1     465.76 GB   976773168     WD-WCASU1168560     
				when /^p([0-9]+)\s+(\S+)\s+u([0-9]+)/
					unitno=$3
					portno=$1
					mapping[unitno] << portno
				end
			}
			# put the physical mapping into the logical-disk structure
			logical.each_index{ |i|
				logical[i][:physical]=mapping[logical[i][:num]]
			}
			return @logical
		end

		# ======================================================================

		def logical_add(raid_level, discs = nil, sizes = nil, options = nil)
			raise NotImplementedError
		end

		def logical_delete(id)
			raise NotImplementedError
		end

		def logical_clear
			raise NotImplementedError
		end

		def _physical_list
			res={} # overall mapping
			run(" show").each { |l|
				# don't query ports with no disks on them
				# that causes tw_cli to throw up :-P
				case l
				when /NOT-PRESENT/
					{} #skip this
				when /^p([0-9]+) /
					p=$1
					res["#{p}"]={}
					# query the details.
					run("/p#{p} show all").each{ |l|
					case l
						when /p#{p} Status = (\S+)/
							res["#{p}"][:state]=$1.downcase
						when /Model = (.*)$/
							res["#{p}"][:model]=$1.strip
						when /Firmware Version = (.*)$/
							res["#{p}"][:revision]=$1.strip
						when /Capacity = ([0-9\.]+)/
							res["#{p}"][:size]=1024*($1.to_f)
						when /Serial = (.*)/
							res["#{p}"][:serial]=$1.strip
					end # case per_port
					}
				end # case this_is_a_valid_port
			}
			return res
		end

		# ======================================================================

		def firmware_read(filename)
			raise NotImplementedError
		end

		def firmware_write(filename)
			raise NotImplementedError
		end

		# ======================================================================

		def get_adapter_raidlevels(x = nil)
			raise NotImplementedError
		end

		def get_adapter_rebuildrate(x = nil)
			raise NotImplementedError
		end

		def set_physical_hotspare_0(drv)
			raise NotImplementedError
		end

		def set_physical_hotspare_1(drv)
			raise NotImplementedError
		end
		
		def get_logical_stripe(num)
			raise NotImplementedError
		end

		# Converts physical name (sda) to SCSI enumeration (1:0)
		def phys_to_scsi(name)
			raise NotImplementedError
		end

		# run one command, instance method
		private
		def run(command)
			#puts("DEBUG: #{TWCLI} /c#{@adapter_num}#{command}")
			out = `#{TWCLI} /c#{@adapter_num}#{command}`.split("\n").collect { |l| l.strip }
			raise Error.new(out.join("\n")) if $?.exitstatus != 0
			return out
		end

		# class method for self.query()
		private
		def self.run(command)
			out = `#{TWCLI} #{command}`.split("\n").collect { |l| l.strip }
			raise Error.new(out.join("\n")) if $?.exitstatus != 0
			return out
		end
	end
end
