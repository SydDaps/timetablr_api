class LecturerTimeTracker < ApplicationRecord
    belongs_to :lecturer
    belongs_to :day
    belongs_to :schedule_time
    belongs_to :time_table
    
end
