class Api::V1::SchedulerController < ApplicationController

	def create
		current_time_table.update!(status: "processing")
		
		ScheduleJob.perform_later(current_time_table)
		
		render json: {
			success: true,
			code: 200,
			data: {
				status: "processing"
			}
		}

	end

	def index

		if current_time_table.status == "Pending" 
			raise Exceptions::UnauthorizedOperation.message("TimeTable still pending, make sure to generate it first")
		end
		

		schedule = current_time_table.schedules.all.map{ |p| PairingSerializer.new( p.pairings ).serialize }.flatten

		if @current_user.class.name == "Student"
			schedule = schedule.select do |l| 
				l[:course][:level_id] == @current_user.level.id && l[:course][:department_id] == @current_user.department.id
			end
		elsif @current_user.class.name == "Lecturer"
			temp = []
			schedule.each do |s|
				if s[:lecturers].find{ |l| l[:id] == @current_user.id }
					temp << s
				end

			end
			
			schedule = temp
		end
		
	

		render json: {
			success: true,
			code: 200,
			data: {
				schedules: schedule
			}
		}
	end
end
