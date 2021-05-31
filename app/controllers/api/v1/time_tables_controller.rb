
class  Api::V1::TimeTablesController < ApplicationController
  def create
    time_table = TimeTableService::Create.call(params, @current_user)

    render json: {
      success: true,
      code: 200,
      data: {
        time_tables: time_table
      },
    }
  end

  def index
    render json: {
      success: true,
      code: 200,
      data: {
        time_tables: @current_user.time_tables
      },
    }
  end
end
