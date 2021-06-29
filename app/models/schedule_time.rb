class ScheduleTime < ApplicationRecord
    has_many :meet_times_days
    has_many :lecturer_time_trackers
    has_many :class_time_trackers
    has_many :room_time_trackers
end
