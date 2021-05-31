class Api::V1::CoursesController < ApplicationController
  def create
    time_table = current_time_table
    courses = []
    Course.transaction do
      params[:courses].each do |course|
        courses << CourseService::Create.call(course.merge(time_table: time_table))
      end
    end

    render json: {
      success: true,
      code: 200,
      data: {
        courses: CourseSerializer.new( courses.flatten ).serialize
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
end
