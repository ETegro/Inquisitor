class TestingStage < ActiveRecord::Base
	belongs_to :testing
	has_many :marks

	RUNNING = 0
	FINISHED = 1
	FAILED = 2
	HANGING = 3
end
