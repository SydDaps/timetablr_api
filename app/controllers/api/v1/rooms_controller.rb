class Api::V1::RoomsController < ApplicationController
    
    def create
        check_params
        rooms = []
        Room.transaction do
            params[:rooms].each do |room|
                rooms  << RoomService::Create.call(room.merge(time_table: current_time_table))
            end
        end

        render json: {
            success: true,
            code: 200,
            data: {
              rooms: RoomSerializer.new( rooms  ).serialize
            }
        }
        
    end

    def index
        render json: {
            success: true,
            code: 200,
            data: {
              rooms: RoomSerializer.new( current_time_table.rooms  ).serialize
            }
        }
    end




    private
    def check_params
        if params[:rooms].blank?
            raise Exceptions::MissingParam, "check Param"
        end

        params[:rooms].each do |room|
            if room[:name].blank? || room[:capacity].blank? || room[:time_tags].blank?
                raise Exceptions::MissingParam, "Enter room name and capacity"
            end
        end

    end
end
