class Course < ApplicationRecord
    has_and_belongs_to_many :lecturers, dependent: :destroy
    has_and_belongs_to_many :time_tags, dependent: :destroy

    has_many :schedules, through: :pairings
    
    belongs_to :level
    belongs_to :department
    belongs_to :time_table

    validates :name, presence: { message: 'for course blank' }
    validates :code, presence: { message: 'for course blank' }
end
