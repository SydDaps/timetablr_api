module CourseService
    class LinkLecturerTag < BaseService
        def initialize(params)
          @course_id = params[:course_id]
          @lecturers = params[:lecturers]
          @time_tags = params[:tags]
        end


        def call
            lecturers = Lecturer.find(@lecturers)
            time_tags = TimeTag.find(@time_tags)
            course = Course.find(@course_id)

            course.lecturers << lecturers
            course.time_tags << time_tags

            course
        end
    end
end