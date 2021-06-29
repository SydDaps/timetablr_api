class RoomTimeTracker < ApplicationRecord
    belongs_to :room
    belongs_to :day
    belongs_to :schedule_time
    belongs_to :time_table
end
