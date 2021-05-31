class Api::V1::DepartmentsController < ApplicationController
    before_action :check_params, only: [:create]

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
              department: DepartmentSerializer.new( departments ).serialize
            },
        }
    end

    def index
        time_table = TimeTable.find(params[:time_table_id])
        
        render json: {
            success: true,
            code: 200,
            data: {
              department: DepartmentSerializer.new( current_time_table.departments.all ).serialize
            },
        }
    end


    private
    def check_params
        if params[:departments].blank?
            raise Exceptions::MissingParam, "Check Params name and code"
        end
       
        params[:departments].each do |department|
            if department[:name].blank? || department[:code].blank?
                raise Exceptions::MissingParam, "Check Params name and code"
            end
        end
    end
end
