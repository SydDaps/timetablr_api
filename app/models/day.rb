class Day < ApplicationRecord
    belongs_to :time_table

    has_and_belongs_to_many :time_tags, dependent: :destroy

    validates :name, presence: { message: 'for Day blank' }
end
