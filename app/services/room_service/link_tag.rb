module RoomService
    class LinkTag < BaseService
        def initialize(params)
            @room_id = params[:room_id]
            @tags = params[:tags]
        end

        def call
            room = Room.find(@room_id)
            room.time_tags.destroy_all

            tag =TimeTag.find(@tags)
            
            room.time_tags << tag
            
            room
        end
    end
end