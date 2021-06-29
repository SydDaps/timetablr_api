class Room < ApplicationRecord
    belongs_to :time_table
    has_and_belongs_to_many :time_tags, dependent: :destroy

    has_many :pairings
    has_many :schedules, through: :pairings, dependent: :destroy
    has_many :room_time_trackers

    validates :name, presence: { message: 'for time table blank' }
    validates :capacity, presence: { message: 'for time table blank' }
end
