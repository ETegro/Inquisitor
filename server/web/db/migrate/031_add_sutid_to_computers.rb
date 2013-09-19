class AddSutidToComputers < ActiveRecord::Migration
        def self.up
                add_column :computers, :sut_id, :integer, :default => 0
        end
        def self.down
                remove_column :computers, :sut_id
        end
end
