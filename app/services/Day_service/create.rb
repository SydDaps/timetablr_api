module DayService
    class Create < BaseService
        def initialize(day_params, time_tag, department)
          @name = day_params[:name]
          @time_tag = time_tag
          @department = department
        end

        def call
            day = @department.days.find_by_name(@name)

            if day
                @time_tag.days << day
            else
                day = @department.time_table.days.new(
                    name: @name
                )

                unless day.valid?
                    @department.destroy
                    day.save!
                end

                day.save!

                @time_tag.days << day
            end
        end

    end
end