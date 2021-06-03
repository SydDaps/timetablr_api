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
end
