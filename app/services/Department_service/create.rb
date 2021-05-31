module DepartmentService
    class Create < BaseService
        def initialize(params)
          @name = params[:name]
          @code = params[:code]
          @time_table = params[:time_table]
        end

        def call
            department = @time_table.departments.create!(
                name: @name,
                code: @code
            )
        end
    end

end