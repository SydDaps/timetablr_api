class ScheduleJob < ApplicationJob
  	queue_as :default

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
		
		total_pairings = 0
		total_courses = 0
		time_table.time_tags.each do |tag|
			total_courses += tag.courses.count
		end
		# while total_pairings !=  total_courses
			total_pairings = ScheduleService::Scheduler.call(params)
		# end

		
		
		
			

		

		puts "-------------"
		puts total_courses
		puts total_pairings

		


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
