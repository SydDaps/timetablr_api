module LecturerService
    class LinkDay < BaseService
        def initialize(params)
            @lecture_schedules = params[:schedules] || []
            @lecturer_id = params[:lecturer_id]
            @time_table = params[:time_table]
        end

        def call
            lecturer = Lecturer.find(@lecturer_id)
            lecturer.lecture_schedules.destroy_all
            Lecturer.transaction do
                @lecture_schedules.each do |ls|
                
                    day = Day.find(ls)
    
                    schedule_time = ScheduleTime.create(
                        start: parse_time("7:30am"),
                        end: parse_time("7:30pm")
                    )
    
                    lecture_schedule = LectureSchedule.create(
                        day: day,
                        schedule_time: schedule_time,
                        time_table: @time_table
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