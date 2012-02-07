#!/usr/bin/env ruby
# server/scannerd/scanner.rb - A part of Inquisitor project
# Copyright (C) 2004-2009 by Iquisitor team 
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'net/http'
require 'rexml/document'
require 'open-uri'

class Scanner
	attr_accessor :dev

	def svals=(sv)
		@svals[ sv=~/\d{10}/ ? 'S' : sv[/./] ] = sv
	end
	
	def svals
		@svals
	end
	
	def initialize(devname)
		puts 'Initialize Scanner'
		@svals = Hash.new
		@dev = File.open(devname)
		$scanners_dev << @dev
	end

	def preprocess_vals()
		@svals.keys.each {|k| @svals[k].sub!(/^\w0*/, '') if ['S', 'A', 'T', 'I', 'O', 'P'].index(k) != nil }
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
					open("http://#{$SERVER_ADDR}/computers/set_checker/#{@svals['S']}?checker_id=#{@svals['T']}")
				    when ['O', 'S'] then
					open("http://#{$SERVER_ADDR}/computers/set_checker/#{@svals['S']}?checker_id=#{@svals['O']}")
				end
				@svals.clear
				return 0
			end
		}
		return 1
	end
end
