class Api::V1::StudentsController < ApplicationController

  skip_before_action :authenticate_request, :only => [:login]

  def index 

    render json: {
      success: true,
      code: 200,
      data: {
        students: StudentSerializer.new( current_time_table.students  ).serialize
      }
    }
  end


  def create

    response = StudentService::Create.call(params.merge(time_table: current_time_table))

    render json: {
      success: true,
      code: 200,
      data: {
        students: StudentSerializer.new( current_time_table.students  ).serialize
      }
    }
    
  end



  def login
    email = params[:email]
    
    student = Student.find_by_email(email)

    token = Jwt::JsonWebToken.encode({student_id: student.id}) if student

    raise Exceptions::NotUniqueRecord.message("The email #{email} has no timetable schedules.") unless student

    render json: {
      success: true,
      code: 200,
      data: {
        user: student,
        read_only: true,
        time_table: TimeTableSerializer.new( student.time_tables ).serialize,
        access_token: token
      },
    }

  end
end
