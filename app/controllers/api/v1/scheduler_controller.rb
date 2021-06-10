	class Api::V1::SchedulerController < ApplicationController

	def create
		current_time_table.schedules.destroy_all
		meet_rooms = ScheduleService::MeetTimeRooms.call({time_table: current_time_table})

		#share days to courses with respect to tags
		days_courses_tags = ScheduleService::CoursesDays.call({time_table: current_time_table})

		#Start Scheduling
		params = {
		courses: days_courses_tags,
		meet_rooms: meet_rooms,
		time_table: current_time_table
		}

		ScheduleService::Scheduler.call(params)

		current_time_table.status = "completed"
		current_time_table.save!



		#ScheduleJob.perform_later(time_table)

		render json: {
			success: true,
			code: 200,
			data: {
				schedules: current_time_table.schedules.all.map{ |p| PairingSerializer.new( p.pairings ).serialize }.flatten
			}
		}

	end
	end
