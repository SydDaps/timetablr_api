class Day < ApplicationRecord
    belongs_to :time_table

    has_and_belongs_to_many :time_tags, dependent: :destroy
    has_and_belongs_to_many :lecturers, dependent: :destroy
    has_and_belongs_to_many :courses, dependent: :destroy

    has_many :schedules, through: :pairings
    has_many :lecture_schedules
    has_many :lecturer_time_trackers
    has_many :class_time_trackers
    has_many :room_time_trackers

    validates :name, presence: { message: 'for Day blank' }
    validates :number, presence: { message: 'for Day blank' }
end
