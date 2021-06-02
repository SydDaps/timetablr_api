
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
        time_tables: TimeTableSerializer.new(@current_user.time_tables).serialize
      },
    }
  end
end
