class Level < ApplicationRecord
    belongs_to :time_table

    has_many :courses
    has_many :class_time_trackers, dependent: :destroy
    has_many :students, dependent: :destroy

    validates :code, presence: { message: 'for level blank' }
    
end
