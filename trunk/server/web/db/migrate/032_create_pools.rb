class CreatePools < ActiveRecord::Migration
	def self.up
		create_table :pools do |t|
			t.column :computer_id, :integer, :null => false
			t.column :group_id, :integer, :default => 0
		end
		create_table :pool_ips do |t|
			t.column :pool_id, :integer, :null => false
			t.column :ip, :string, :limit => 20
		end
	end
	def self.down
		drop_table :pools
		drop_table :pool_ips
	end
end
