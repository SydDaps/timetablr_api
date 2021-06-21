class Lecturer < ApplicationRecord
    has_secure_password

    has_and_belongs_to_many :courses, dependent: :destroy
    has_and_belongs_to_many :time_tables, dependent: :destroy
    has_and_belongs_to_many :days, dependent: :destroy

    has_many :lecture_schedules

    
    validates :name, presence: { message: 'for lecturer blank' }
    validates :email, presence: { message: 'for lecturer blank' }
end
