class RoomCategory < ApplicationRecord
    belongs_to :time_table
    has_many :rooms, dependent: :destroy
end
