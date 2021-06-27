module ScheduleService
    class MeetTimeRooms < BaseService
        def initialize(params)
          @time_table = params[:time_table]
        end

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