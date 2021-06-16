class Api::V1::SchedulerController < ApplicationController

	def create

		ScheduleJob.perform_later(current_time_table)
		current_time_table.update!(status: "processing")
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

		render json: {
			success: true,
			code: 200,
			data: {
				schedules: current_time_table.schedules.all.map{ |p| PairingSerializer.new( p.pairings ).serialize }.flatten
			}
		}
	end
end
