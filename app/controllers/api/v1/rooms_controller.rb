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

    def update
        room = Room.find(params[:id])
        
        room.update!(update_params)

        old_room_tags = []
        
        
           
        current_time_table.schedules.destroy_all
        current_time_table.update!(status: "pending")
        room.time_tags.destroy_all

        room = {
            room_id: room.id,
            tags: params[:tags]
        }

        RoomService::LinkTag.call(room)
        
        

        
        render json: {
            success: true,
            code: 200,
            data: {
                rooms: RoomSerializer.new( current_time_table.rooms  ).serialize
            },
        }
    end
  
    def destroy
        current_time_table.schedules.destroy_all
        current_time_table.update!(status: "pending")
        Room.destroy(params[:id])
    
        render json: {
            success: true,
            code: 200,
            data: {
                rooms: RoomSerializer.new( current_time_table.rooms  ).serialize
            },
        }
    end

    private

    def update_params
        params.permit(:name, :capacity)
    end

end
