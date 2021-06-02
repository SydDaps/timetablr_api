module DayService
    class Create < BaseService
        def initialize(params)
          @name = params[:name]
          @number = params[:number]
          @time_table = params[:time_table]
        end

        def call
            day = @time_table.days.create!(
                name: @name,
                number: @number
            )
        end
    end
end