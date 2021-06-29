class ClassTimeTracker < ApplicationRecord
    belongs_to :level
    belongs_to :department
    belongs_to :day
    belongs_to :schedule_time
    belongs_to :time_table
end
