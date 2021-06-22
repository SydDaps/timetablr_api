module LecturerService
    class LinkDay < BaseService
        def initialize(params)
            @lecture_schedules = params[:lecture_schedules]
            @lecturer_id = params[:lecturer_id]
        end

        def call
            lecturer = Lecturer.find(@lecturer_id)
            
            Lecturer.transaction do
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

        end

        private

        def parse_time(time)
            if time 
                return Time.parse(time)
            end
        end


    end
end