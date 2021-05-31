class Room < ApplicationRecord
    belongs_to :time_table
    has_and_belongs_to_many :time_tags

    validates :name, presence: { message: 'for time table blank' }
    validates :capacity, presence: { message: 'for time table blank' }
end
