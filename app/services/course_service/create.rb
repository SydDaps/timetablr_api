module CourseService
    class Create < BaseService
        def initialize(params)
          @name = params[:name]
          @code = params[:code]
          @department_id = params[:department_id]
          @level_id = params[:level_id]
          @time_table = params[:time_table]
        end

        def call
            #this will throw an error if data not found
            Department.find(@department_id)
            Level.find(@level_id)
            
            course = Course.create!(
                name: @name,
                code: @code,
                level_id: @level_id,
                department_id: @department_id,
                time_table_id: @time_table.id
            )
        end

    end
end
