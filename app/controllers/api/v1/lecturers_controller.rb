class Api::V1::LecturersController < ApplicationController

    skip_before_action :authenticate_request, :only => [:login]

    def create
        time_table = current_time_table

        Lecturer.transaction do
            params[:lecturers].each do |lecturer|
                LecturerService::Create.call(lecturer.merge(time_table: time_table))
            end
        end

        render json: {
            success: true,
            code: 200,
            data: {
              lecturers: LecturerSerializer.new( current_time_table.lecturers ).serialize
            }
        }
    end

    def link_days
        
        params[:lecturers].each do |lecturer|
            LecturerService::LinkDay.call(lecturer.merge(time_table: current_time_table))
        end
        

        render json: {
            success: true,
            code: 200,
            data: {
              lecturers: LecturerSerializer.new( current_time_table.lecturers ).serialize
            }
        }
    end

    def destroy
        lecturer = Lecturer.find(params[:id])
        current_time_table.schedules.destroy_all
        current_time_table.update!(status: "pending")
        current_time_table.courses.joins(:lecturers).where(
            lecturers: {id: lecturer.id }
        ).each{ |c| c.lecturers.destroy( lecturer.id )}

        current_time_table.lecturers.destroy(lecturer.id)

        render json: {
            success: true,
            code: 200,
            data: {
              lecturers: LecturerSerializer.new( current_time_table.lecturers ).serialize
            }
        }

    end

    def index
        render json: {
            success: true,
            code: 200,
            data: {
              lecturers: LecturerSerializer.new( current_time_table.lecturers ).serialize
            }
        }
    end

    def login
        email = params[:email]
    
        lecturer = Lecturer.find_by_email(email)

        token = Jwt::JsonWebToken.encode({lecturer_id: lecturer.id}) if lecturer

        raise Exceptions::NotUniqueRecord.message("The email #{email} has no timetable schedules.") unless lecturer

        render json: {
            success: true,
            code: 200,
            data: {
                lecturer: lecturer,
                time_table: TimeTableSerializer.new( lecturer.time_tables ).serialize,
                access_token: token
            },
        }

    end

    
end
