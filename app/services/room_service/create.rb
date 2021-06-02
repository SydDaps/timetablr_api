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
        end

    end
end