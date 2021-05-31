module TimeTagService
    class Create < BaseService
        def initialize(params)
          @name = params[:name]
          @duration = params[:duration]
          @start_at = "7:30am"
          @end_at = "7:30pm"
          @time_table = params[:time_table]
        end

        def call
            time_tag = @time_table.time_tags.create!(
                name: @name,
                duration: parse_duration,
                start_at: parse_time(@start_at),
                end_at: parse_time(@end_at)
            )
        end

        private
        def parse_duration
            @duration.first.hours + @duration.second.minutes
        end

        def parse_time(time)
            if time 
                return Time.parse(time)
            end
        end

    end


end