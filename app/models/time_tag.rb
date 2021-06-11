class TimeTag < ApplicationRecord
    after_create :set_meet_times
    attribute :duration, :interval
    
    belongs_to :time_table

    has_many :courses, dependent: :destroy
    has_many :meet_times, dependent: :destroy
    has_one :room_category, dependent: :destroy

    has_and_belongs_to_many :days
    has_and_belongs_to_many :rooms
    has_and_belongs_to_many :courses, dependent: :destroy

    has_many :schedules, through: :pairings

    validates :name, presence: { message: 'for time tag blank' }
    validates :duration, presence: { message: 'for time tag blank' }
    validates :start_at, presence: { message: 'for time tag blank' }
    validates :end_at, presence: { message: 'for time tag blank' }

    def set_meet_times
        current_end_time = self.start_at + self.duration
        while current_end_time <= self.end_at
            
            self.meet_times.create!({
                start: current_end_time - self.duration,
                end: current_end_time 
            })
            
            current_end_time += self.duration
        end
    end
end
