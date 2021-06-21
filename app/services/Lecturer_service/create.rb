module LecturerService
    class Create < BaseService
        def initialize(params)
          @name = params[:name]
          @email = params[:email]
          @time_table = params[:time_table]
          @lecture_schedules = params[:lecture_schedules]
        end

        def  call
            lecturer = Lecturer.find_by_email(@email)
            
            unless lecturer
                lecturer = Lecturer.create!(
                    name: @name,
                    email: @email,
                    password: "0000"
                )
            end

            unless @time_table.lecturers.find_by_id(lecturer.id)
                @time_table.lecturers << lecturer
            end

            @lecture_schedules.each do |ls|
                
                day = Day.find(ls[:day])

                schedule_time = ScheduleTime.create(
                    start_at: parse_time(ls[:start_at]),
                    end_at: parse_time(ls[:end_at])
                )

                lecture_schedule = LectureSchedule.create(
                    day: day,
                    schedule_time: schedule_time
                )

                lecturer.lecture_schedules << lecture_schedule
            end
        end

        private

        def parse_time(time)
            if time 
                return Time.parse(time)
            end
        end

    end
end 