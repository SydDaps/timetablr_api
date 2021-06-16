class ScheduleJob < ApplicationJob
  	queue_as :high

	def perform(time_table)

		puts time_table.name
		puts time_table.name
		puts time_table.name
		puts time_table.name
		puts time_table.name
		puts time_table.name
		puts time_table.name
		#check all possible classes can take place in a day with respect to tags
		time_table.schedules.destroy_all
		
		meet_rooms = ScheduleService::MeetTimeRooms.call({time_table: time_table})

		#share days to courses with respect to tags
		days_courses_tags = ScheduleService::CoursesDays.call({time_table: time_table})

		#Start Scheduling
		params = {
			courses: days_courses_tags,
			meet_rooms: meet_rooms,
			time_table: time_table
		}
	
		ScheduleService::Scheduler.call(params)

		time_table.update!(status: "completed")

		data = {
			schedules: time_table.schedules.all.map{ |p| PairingSerializer.new( p.pairings ).serialize }.flatten
		}

		user_id = time_table.user.id

		ActionCable.server.broadcast(
			"admin_#{user_id}", 
			{
				time_table: time_table,
				data: data,
			}
		)
	end 

end
