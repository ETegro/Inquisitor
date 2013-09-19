class AddFieldsToPeople4 < ActiveRecord::Migration
  def self.up
	add_column :people, :is_manager, :boolean, :default => false

  end

  def self.down
	remove_column :people, :is_manager
  end
end
