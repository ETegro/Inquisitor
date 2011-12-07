#!/usr/bin/env /srv/inq/web/script/runner

[Computer, Order, Profile, Model].each { |cl|
	cl.reflect_on_all_associations.each { |a|
		p a
		case a.macro
		when :belongs_to
			puts "SELECT * FROM #{cl.table_name} LEFT JOIN #{a.table_name} ON #{a.table_name}.#{a.primary_key_name};"
		end
	}
}