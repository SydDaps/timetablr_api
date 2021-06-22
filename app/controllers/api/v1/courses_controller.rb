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
        courses: DepartmentLevelCoursesSerializer.new( current_time_table.departments ).serialize
      }
    }
  end

  def index 
    render json: {
      success: true,
      code: 200,
      data: {
        courses: DepartmentLevelCoursesSerializer.new( current_time_table.departments ).serialize
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
          courses: DepartmentLevelCoursesSerializer.new( current_time_table.departments ).serialize
        }
      }
    end
  
  end

  def update
    course = Course.find(params[:id])
    course.update(update_params)

    course.lecturers.destroy_all
    course.time_tags.destroy_all
    
    ff = {
      course_id: course.id,
      tags: params[:tags],
      lecturers: params[:lecturers]
    }

    CourseService::LinkLecturerTag.call( ff )
   

    render json: {
      success: true,
      code: 200,
      data: {
        courses: CourseSerializer.new( current_time_table.courses ).serialize
      }
    }
  end
  
  def destroy
    current_time_table.schedules.destroy_all
    current_time_table.update!(status: "pending")
    Course.destroy(params[:id])

    render json: {
        success: true,
        code: 200,
        data: {
          courses: CourseSerializer.new( current_time_table.courses ).serialize
        }
    }
  end

  private

  def update_params
    params.permit(:code, :name)
  end



end
