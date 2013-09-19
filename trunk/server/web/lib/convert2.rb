def convert_db
	puts 'converting graphs with ID=0...'
	g = Graph.find_all_by_monitoring_id(0)
	puts "size: #{g.size}"
	g.select{|x| x.key < 100 }.each{|x| x.monitoring_id = 2 }.each{|x| x.save }
	g.select{|x| (x.key > 99) and (x.key < 200) }.each{|x| x.monitoring_id = 4; x.key = x.key - 100 }.each{|x| x.save }
	puts 'done'
end