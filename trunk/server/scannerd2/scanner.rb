#!/usr/bin/env ruby

require 'net/http'
require 'rexml/document'
require 'open-uri'

class Scanner
	attr_accessor :dev

	def svals=(sv)
		puts "sv=#{sv}"
		@svals[ sv=~/\d{10}/ ? 'S' : sv[/./] ] = sv
#		puts @svals['S']
#		puts @svals['P']
	end
	
	def svals
		@svals
	end
	
	def initialize(devname)
		puts 'Initialize Scanner'
		@svals = Hash.new
		@dev = File.open(devname)
		$scanners_dev << @dev
#		p @svals
#		p @dev
	end

	def preprocess_vals()
		@svals.keys.each {|k| @svals[k].sub!(/^\w0*/, '') if ['S', 'A', 'T', 'I'].index(k) != nil }
	end
	
	def process_vals()
		return -1 if @svals.size > 5
		$PAIRED_SCANS.each { |ps|    
			if @svals.keys.sort! == ps.sort! then
				puts "Scanned values:"
				puts "=====>#{@svals['S']}"
	    			preprocess_vals()
				case ps
				    when ['P', 'S'] then
					open("http://#{$SERVER_ADDR}/computers/add_component/#{@svals['S']}.xml?type=Power+Supply&vendor=ColdWatt&model=CWA2-0650-10-IV01&serial=#{@svals['C']}")
				    when ['C', 'S'] then
					open("http://#{$SERVER_ADDR}/computers/add_component/#{@svals['S']}.xml?type=Power+Supply&vendor=ColdWatt&model=CWA2-0650-10-IV01&serial=#{@svals['C']}")
				    when ['S', 'T'] then
#				    	puts "http://#{$SERVER_ADDR}/computers/set_checker/#{@svals['S']}?checker_id=#{@svals['T']}"
					open("http://#{$SERVER_ADDR}/computers/set_checker/#{@svals['S']}?checker_id=#{@svals['T']}")
				    
				end
				@svals.clear
				return 0
			end
		}
		return 1
	end
end
