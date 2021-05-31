module RoomService
    class Create < BaseService
        def initialize(params)
          @name = params[:name]
          @capacity = params[:capacity]
          @time_table = params[:time_table]
          @time_tags = params[:time_tags]
        end

        def call
            room = @time_table.rooms.create!(
                name: @name,
                capacity: @capacity
            )

            @time_tags.each do |time_tag_id|
                time_tag = TimeTag.find_by_id(time_tag_id)
                unless time_tag
                    raise Exceptions::MissingParam, "Time Tag for id #{time_tag_id} not found"
                end

                room.time_tags << time_tag
            end


            room
        end

    end
end