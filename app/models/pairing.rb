class Pairing < ApplicationRecord
	belongs_to :course
	belongs_to :room
	belongs_to :meet_time
	belongs_to :schedule
    belongs_to :day
    belongs_to :time_tag
end
