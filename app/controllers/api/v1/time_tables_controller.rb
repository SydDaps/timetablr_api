
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


end
