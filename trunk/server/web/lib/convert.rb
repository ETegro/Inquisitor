def convert_db
	puts 'converting grpahs with ID=0...'
	g = Graph.find_all_by_monitoring_id(0)
	puts "size: #{g.size}"
#	g.select{|x| x.key < 100 }.each{|x| x.monitoring_id = 1 }.each{|x| x.save }
	g.select{|x| (x.key > 99) and (x.key < 200) }.each{|x| x.monitoring_id = 3; x.key = x.key - 100 }.each{|x| x.save }
	g.select{|x| (x.key > 999) and (x.key < 2000) }.each{|x| x.monitoring_id = 3; x.key = x.key - 1000 }.each{|x| x.save }
	puts 'done'

	puts 'converting graphs with ID=2...'
	g = Graph.find_all_by_monitoring_id(2)
	puts "size: #{g.size}"
#	g.select{|x| x.key < 100 }.each{|x| x.monitoring_id = 1 }.each{|x| x.save }
	g.select{|x| (x.key > 99) and (x.key < 200) }.each{|x| x.monitoring_id = 3; x.key = x.key - 100 }.each{|x| x.save }
	g.select{|x| (x.key > 999) and (x.key < 2000) }.each{|x| x.monitoring_id = 3; x.key = x.key - 1000 }.each{|x| x.save }
	puts 'done'
	
	puts 'converting graphs with ID=4...'
	g = Graph.find_all_by_monitoring_id(4)
	puts "size: #{g.size}"
#	g.select{|x| x.key < 100 }.each{|x| x.monitoring_id = 2 }.each{|x| x.save }
	g.select{|x| (x.key > 99) and (x.key < 200) }.each{|x| x.monitoring_id = 4; x.key = x.key - 100 }.each{|x| x.save }
	puts 'done'

	puts 'converting graphs with ID=3...'
	g = Graph.find_all_by_monitoring_id(3)
	puts "size: #{g.size}"
#	g.select{|x| x.key < 100 }.each{|x| x.monitoring_id = 6 }.each{|x| x.save }
	puts 'done'

	puts 'converting graphs with ID=1...'
	g = Graph.find_all_by_monitoring_id(1)
	puts "size: #{g.size}"
#	g.select{|x| x.key < 100 }.each{|x| x.monitoring_id = 5 }.each{|x| x.save }
	puts 'done'
end