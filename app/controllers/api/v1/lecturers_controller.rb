class Api::V1::LecturersController < ApplicationController

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
              lecturers: LecturerSerializer.new( time_table.lecturers ).serialize
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

    
end
