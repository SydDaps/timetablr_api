module CourseService
    class Create < BaseService
        def initialize(params)
          @name = params[:name]
          @code = params[:code]
          @department_id = params[:department_id]
          @level_id = params[:level_id]
          @lecturers = params[:lecturers]
          @time_tags = params[:time_tags]
          @time_table = params[:time_table]
        end

        def call
            courses = []
            
            @lecturers = @time_table.lecturers.find(@lecturers)
    

            @time_tags.each do |time_tag|
                
            
                course = Course.create!(
                    name: @name,
                    code: @code,
                    level_id: @level_id,
                    time_tag_id: time_tag,
                    department_id: @department_id,
                    time_table_id: @time_table.id
                )

                course.lecturers << @lecturers

                courses << course
            end

            courses
        end

    end
end
