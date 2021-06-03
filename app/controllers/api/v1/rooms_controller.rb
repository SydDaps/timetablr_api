class Api::V1::RoomsController < ApplicationController
    
    def create
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

    def link_tags
        rooms = []
        Room.transaction do
            params[:rooms].each do |room|
                rooms << RoomService::LinkTag.call(room)
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
    
end
