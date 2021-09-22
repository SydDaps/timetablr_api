module ScheduleService
    class MeetTimeRooms < BaseService
        def initialize(params)
          @time_table = params[:time_table]
        end

        # Data structuring here 
        # Aim is to pair a single  meet_time to every room available for every time_tag
        # think of venu1, venu2, venu3 at 7:30 to 9:30  and same venu1, venu2, venu3 at 8:30 to 10:30
        # Data submitted is a hash that has Return[:time_tag id] then it has an array of rooms and specified meet_time 

        def call
            meet_times = {}
            @time_table.time_tags.each do |time_tag|
                meet_times[time_tag.id] = []
                time_tag.meet_times.order(start: :asc).each do |meet_time|
                    time_tag.rooms.each do |room|
                        meet_times[time_tag.id].push(
                            {
                                meet_time: meet_time,
                                room: room
                            }
                        )
                    end
                end
            end

            meet_times
        end
    end
end