module RoomService
    class LinkTag < BaseService
        def initialize(params)
            @room_id = params[:room_id]
            @tags = params[:tags]
        end

        def call
            room = Room.find(@room_id)

            @tags.each do |tag_id|
                tag =TimeTag.find(tag_id)
                room.time_tags << tag
            end
            
            room
        end
    end
end