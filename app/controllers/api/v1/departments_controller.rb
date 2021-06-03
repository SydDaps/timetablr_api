class Api::V1::DepartmentsController < ApplicationController


    def create
        departments = []
        Department.transaction  do
            params[:departments].each  do |department|
                departments << DepartmentService::Create.call(department.merge(time_table: current_time_table))
            end
        end

        render json: {
            success: true,
            code: 200,
            data: {
              departments: DepartmentSerializer.new( departments ).serialize
            },
        }
    end

    def index
        time_table = TimeTable.find(params[:time_table_id])
        
        render json: {
            success: true,
            code: 200,
            data: {
              departments: DepartmentSerializer.new( current_time_table.departments.all ).serialize
            },
        }
    end
end
