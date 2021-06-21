class CourseSchedule < ApplicationRecord
    belongs_to :course
    belongs_to :day
    belongs_to :schedule_time
end
