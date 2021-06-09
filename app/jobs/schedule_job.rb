class ScheduleJob < ApplicationJob
  	queue_as :default

	def perform(time_table)
		#check all possible classes can take place in a day with respect to tags
		

	end

end
