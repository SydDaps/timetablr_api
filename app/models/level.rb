class Level < ApplicationRecord
    belongs_to :time_table

    validates :code, presence: { message: 'for level blank' }
    
end
