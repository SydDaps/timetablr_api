class MeetTime < ApplicationRecord
    belongs_to :time_tag

    has_many :pairings, dependent: :destroy
    has_many :schedules, through: :pairings
    has_many :courses, through: :pairings
    has_many :days, through: :pairings
end
