class TimeTable < ApplicationRecord
    
    belongs_to :user

    has_many :departments, dependent: :destroy
    has_many :days, dependent: :destroy
    has_many :rooms, dependent: :destroy
    has_many :time_tags, dependent: :destroy
    has_many :levels, dependent: :destroy
    has_many :courses, dependent: :destroy

    has_and_belongs_to_many :lecturers

    validates :name, presence: { message: 'for time table blank' }
    validates :kind, inclusion: { in: %w(class exams),
        message: "%{value} is not a valid kind"
    }
    validates :category, inclusion: { in: %w(undergrad masters others diploma),
        message: "%{value} is not  a valid kind"
    }

end
