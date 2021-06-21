class LectureSchedule < ApplicationRecord
    belongs_to :lecturer
    belongs_to :day
    belongs_to :schedule_time
end
