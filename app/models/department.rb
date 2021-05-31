class Department < ApplicationRecord
    belongs_to :time_table

    has_many :courses, dependent: :destroy

    validates :name, presence: { message: 'for Department blank' }
    validates :code, presence: { message: 'for Department blank' }
end
