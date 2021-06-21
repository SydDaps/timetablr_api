class Api::V1::LevelsController < ApplicationController

    def create
        levels = []
        time_table = current_time_table
        Level.transaction do
            params[:levels].each do |level|
              levels << LevelService::Create.call(level.merge(time_table: time_table)) 
            end
        end

        render json: {
            success: true,
            code: 200,
            data: {
              levels: LevelSerializer.new( levels ).serialize
            }
        }
    end 


    def index
        render json: {
            success: true,
            code: 200,
            data: {
              levels: LevelSerializer.new( current_time_table.levels ).serialize
            }
        }
    end

    def update
      level = Level.find(params[:id])

      level.update!(update_params)

      render json: {
          success: true,
          code: 200,
          data: {
            levels: LevelSerializer.new( current_time_table.levels ).serialize
          },
      }
    end

  def destroy
    current_time_table.schedules.destroy_all
    current_time_table.update!(status: "pending")
    Level.destroy(params[:id])

    render json: {
      success: true,
      code: 200,
      data: {
        levels: LevelSerializer.new( current_time_table.levels ).serialize
      },
    }
  end

  private

  def update_params
      params.permit(:level, :code)
  end
end
