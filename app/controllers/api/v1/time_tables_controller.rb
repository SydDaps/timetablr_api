
class  Api::V1::TimeTablesController < ApplicationController
  def create
    time_table = TimeTableService::Create.call(params, @current_user)

    Day.transaction do 
      params[:days].each do |day|
        DayService::Create.call(day.merge(time_table: time_table))
      end
    end

    render json: {
      success: true,
      code: 200,
      data: {
        time_table: TimeTableSerializer.new(time_table).serialize
      },
    }
  end

  def index
  
    render json: {
      success: true,
      code: 200,
      data: {
        time_tables: TimeTableSerializer.new(@current_user.time_tables.order("updated_at DESC")).serialize
      },
    }
  end

  def show
    time_table = TimeTable.find(params[:id])
    render json: {
      success: true,
      code: 200,
      data: {
        time_tables: TimeTableSerializer.new( time_table ).serialize
      },
    }
  end

  def publish
    
    if current_time_table.status.downcase == "pending"
      raise Exceptions::NotUniqueRecord.message("Timetable needs to be completed before publishing")
    end

    students = current_time_table.students.map{ |s| s.email }
    lecturers = current_time_table.lecturers.map{ |l| l.email }

    
    params = {
      emails: ["Sydneyyork139@gmail.com"] + students ,
      time_table: current_time_table,
      user: @current_user
    }

    MailJob.perform_later(params)

    
    render json: {
      success: true,
      code: 200,
      data: {
        message: "Timetable is being published"
      },
    }
        
  end

end

