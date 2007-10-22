#!/usr/bin/env ruby
require 'raid/baseraid'

COMPUTER_ID=ENV['COMPUTER_ID']

def temporary_workaround(cmd)
	`TEST_NAME=hdd . /usr/share/inquisitor/functions-test && export COMPUTER_ID=#{COMPUTER_ID} && ${cmd}`
end

temporary_workaround("test_started 100")

def test_available
	drivenames = `ls -1 /sys/block/ | grep -v '[0-9]$'`.split(/\n/)
	puts "Drivenames: #{drivenames.join(',')}"
	system("./hdd-badblocks.rb #{drivenames.join(' ')}")
	return drivenames.size
end

adapters = []
RAID::BaseRaid::query_adapters.each { |ad|
	a = RAID::RAIDS[ad[:driver]].new(ad[:num])	
	adapters << a
	a.logical_clear
	a.adapter_restart
}

test_available

adapters.each { |a|
	a.logical_clear
	pl = a._physical_list.keys
	while pl.size > 0
		# Select 8 discs to test
		now_testing = []
		8.times { now_testing << pl.pop }
		now_testing.compact!
		puts "Testing #{now_testing.join(',')}"

		# Prepare passthroughs
		a.logical_clear
		now_testing.each { |disc|
			a.logical_add('passthrough', disc, nil)
		}
		a.adapter_restart
		sleep 5
		test_available
	end
}

temporary_workaround("test_succeeded")
