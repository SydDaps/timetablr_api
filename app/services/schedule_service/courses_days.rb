module ScheduleService
    class CoursesDays < BaseService
        def initialize(params)
          @time_table = params[:time_table]
        end



        # course are being structured with tags so courses_tags[timetag id] = [{time_tag: of particular tag, course: particular course}]
        def call
            courses_tags = []

            
            courses_tags = {}
           
            @time_table.time_tags.each do |tag|
                courses_tags[tag.id] = []
                courses_tags[tag.id] = tag.courses.map{ |course| { time_tag: tag, course: course} }
            end
            

            courses_tags.transform_values{ |v| v.shuffle }
        end
    end
end