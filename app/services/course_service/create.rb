module CourseService
    class Create < BaseService
        def initialize(params)
          @name = params[:name]
          @code = params[:code]
          @department_id = params[:department_id]
          @level_id = params[:level_id]
          @time_table = params[:time_table]
          @elective = params[:elective]
          @course_schedules = params[:course_schedules]
        end

        def call
            #this will throw an error if data not found
            kind = "compulsory"
            if @elective
                kind = "elective" if @elective.upcase == "Y"
            end
            Department.find(@department_id)
            Level.find(@level_id)
            
            course = Course.create!(
                name: @name,
                code: @code,
                level_id: @level_id,
                department_id: @department_id,
                time_table_id: @time_table.id,
                kind: kind
            )

            @course_schedules.each do |cs|
                
                day = Day.find(cs[:day])

                schedule_time = ScheduleTime.create(
                    start_at: parse_time(cs[:start_at]),
                    end_at: parse_time(cs[:end_at])
                )

                course_schedule = CourseSchedule.create(
                    day: day,
                    schedule_time: schedule_time
                )

                course.course_schedules << course_schedule
               
            end

            course
        end

        private

        def parse_time(time)
            if time 
                return Time.parse(time)
            end
        end

    end
end
