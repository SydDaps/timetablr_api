module RoomCategoryService
    class Create < BaseService
        def initialize(params, time_table)
          @name = params[:category]
          @room = params[:room]
          @time_table = time_table
        end

        def call
            room_category = @time_table.room_categories.find_by_name( @name )

            if room_category
                RoomService::Create.call(@room, room_category)
            else 
                room_category = @time_table.room_categories.new(
                    name: @name
                )
                
                unless room_category.valid?
                    room_category.destroy
                    room_category.save!
                end

                room_category.save!
                
                RoomService::Create.call(@room, room_category)
            end

            room_category
        end

    end
end