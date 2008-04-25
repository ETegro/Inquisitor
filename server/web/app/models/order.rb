class Order < ActiveRecord::Base
	has_many :order_lines
	has_many :order_stages, :order => 'start'
	has_many :computers

	def update_order(attr)
		order_lines = attr[:order_lines]
		attr.delete(:order_lines)
		p order_lines
		update_attributes(attr)
	end

	def self.staging(manager = nil)
		if manager and not manager.empty?
			add_filter = "AND o.manager=?"
			add_arg = manager
		else
			add_filter = ''
			add_arg = nil
		end		
		[
			self.find_by_sql(["SELECT o.id, o.buyer_order_number, o.title, o.customer, os.start, DATEDIFF(NOW(), os.start) AS from_delay FROM orders o
INNER JOIN order_stages os ON o.id=os.order_id
WHERE os.stage='ordering' AND os.end IS NULL #{add_filter} AND os.start > '2008-01-01'
ORDER BY from_delay ASC", add_arg]),
			self.find_by_sql(["SELECT o.id, o.buyer_order_number, o.title, o.customer, os.start, DATEDIFF(NOW(), os.start) AS from_delay FROM orders o
INNER JOIN order_stages os ON o.id=os.order_id
WHERE os.stage='warehouse' AND os.end IS NULL #{add_filter}
ORDER BY from_delay ASC", add_arg]),
			self.find_by_sql(["SELECT o.id, o.buyer_order_number, o.title, o.customer, os.start, DATEDIFF(NOW(), os.start) AS from_delay FROM orders o
INNER JOIN order_stages os ON o.id=os.order_id
WHERE os.stage='acceptance' AND os.end IS NULL #{add_filter}
ORDER BY from_delay ASC", add_arg]),
			self.find_by_sql(["SELECT o.id, o.buyer_order_number, o.title, o.customer, cs.start, DATEDIFF(NOW(), cs.start) AS from_delay, COUNT(c.id) AS comp_qty FROM orders o
INNER JOIN computers c ON c.order_id=o.id
LEFT JOIN computer_stages cs ON cs.computer_id=c.id
WHERE cs.stage='assembling' AND cs.end IS NULL #{add_filter}
GROUP BY o.id
ORDER BY from_delay DESC", add_arg]),
			self.find_by_sql(["SELECT o.id, o.buyer_order_number, o.title, o.customer, cs.start, DATEDIFF(NOW(), cs.start) AS from_delay, COUNT(c.id) AS comp_qty FROM orders o
INNER JOIN computers c ON c.order_id=o.id
LEFT JOIN computer_stages cs ON cs.computer_id=c.id
WHERE cs.stage='testing' AND cs.end IS NULL #{add_filter}
GROUP BY o.id
ORDER BY from_delay DESC", add_arg]),
			self.find_by_sql(["SELECT o.id, o.buyer_order_number, o.title, o.customer, cs.start, DATEDIFF(NOW(), cs.start) AS from_delay, COUNT(c.id) AS comp_qty FROM orders o
INNER JOIN computers c ON c.order_id=o.id
LEFT JOIN computer_stages cs ON cs.computer_id=c.id
WHERE cs.stage='checking' AND cs.end IS NULL #{add_filter}
GROUP BY o.id
ORDER BY from_delay DESC", add_arg]),
			self.find_by_sql(["SELECT o.id, o.buyer_order_number, o.title, o.customer, cs.start, DATEDIFF(NOW(), cs.start) AS from_delay FROM orders o
INNER JOIN computers c ON c.order_id=o.id
LEFT JOIN computer_stages cs ON cs.computer_id=c.id
WHERE cs.stage='packing' AND cs.end IS NULL #{add_filter}
ORDER BY from_delay DESC", add_arg]),
		]
	end

	def self.with_testings
                Order.find_by_sql("select distinct orders.* from computers inner join testings on testings.computer_id = computers.id inner join orders on computers.order_id = orders.id where testings.id is not null order by orders.buyer_order_number")
	end
end
