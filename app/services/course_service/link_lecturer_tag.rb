module CourseService
    class LinkLecturerTag < BaseService
        def initialize(params)
          @course_id = params[:course_id]
          @lecturers = params[:lecturers]
          @time_tags = params[:time_tags]
          @schedules = params[:schedules] || []
        end


        def call
            lecturers = Lecturer.find(@lecturers)

            time_tags = TimeTag.find(@time_tags)

            course = Course.find(@course_id)

            course.lecturers.destroy_all

            course.time_tags.destroy_all

            course.lecturers << lecturers
            course.time_tags << time_tags

            @schedules.each do |cs|
                
                day = Day.find(cs)

                schedule_time = ScheduleTime.create(
                    start_at: parse_time("7:30am"),
                    end_at: parse_time("7:30pm")
                )

                course_schedule = CourseSchedule.create(
                    day: day,
                    schedule_time: schedule_time
                )

                course.course_schedules << course_schedule
               
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