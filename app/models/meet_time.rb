class MeetTime < ApplicationRecord
    belongs_to :time_tag

    has_many :schedules, through: :pairings
end
