class Api::V1::CoursesController < ApplicationController
  def create
    time_table = current_time_table
    courses = []
    Course.transaction do
      params[:courses].each do |course|
        department_id = course[:department_id]
        course[:levels].each do |level|
          level_id = level[:level_id]
          level[:courses].each do |course|
            
            data = {
              level_id: level_id,
              department_id:  department_id,
              time_table: time_table
            }

            courses << CourseService::Create.call(course.merge(data))
          end
        end
      end
    end

    render json: {
      success: true,
      code: 200,
      data: {
        courses: CourseSerializer.new( courses ).serialize
      }
  }
  end

  def index 
    render json: {
      success: true,
      code: 200,
      data: {
        courses: CourseSerializer.new( current_time_table.courses ).serialize
      }
    }
  end

  def link_lecturers_tags
    courses = []
    Course.transaction do
      params[:courses].each do |course|
        courses << CourseService::LinkLecturerTag.call( course )
      end

      render json: {
        success: true,
        code: 200,
        data: {
          courses: CourseSerializer.new( courses ).serialize
        }
      }
    end
  
  end
end
