class Level < ApplicationRecord
    belongs_to :time_table

    has_many :courses
    

    validates :code, presence: { message: 'for level blank' }
    
end
