class OrderStage < ActiveRecord::Base
	belongs_to :order
	belongs_to :person

	include Timespans
end
