class Pool < ActiveRecord::Base
	has_many :pool_ips
	def ips
		PoolIp.find_all_by_pool_id( self.id ).collect{ |ip| ip.ip }
	end
end
