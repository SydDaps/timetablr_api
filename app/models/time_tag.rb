class TimeTag < ApplicationRecord
    attribute :duration, :interval
    
    belongs_to :time_table

    has_many :courses, dependent: :destroy
    has_one :room_category, dependent: :destroy

    has_and_belongs_to_many :days
    has_and_belongs_to_many :rooms
    has_and_belongs_to_many :courses, dependent: :destroy

    validates :name, presence: { message: 'for time tag blank' }
    validates :duration, presence: { message: 'for time tag blank' }
    validates :start_at, presence: { message: 'for time tag blank' }
    validates :end_at, presence: { message: 'for time tag blank' }
end
