class Day < ApplicationRecord
    belongs_to :time_table

    has_and_belongs_to_many :time_tags, dependent: :destroy
    
    has_many :course_schedules
    
    has_many :schedules, through: :pairings
    has_many :lecture_schedules, dependent: :destroy
    has_many :lecturer_time_trackers, dependent: :destroy
    has_many :class_time_trackers, dependent: :destroy
    has_many :room_time_trackers, dependent: :destroy

    validates :name, presence: { message: 'for Day blank' }
    validates :number, presence: { message: 'for Day blank' }
end
