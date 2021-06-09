class Lecturer < ApplicationRecord
    has_secure_password

    has_and_belongs_to_many :courses, dependent: :destroy
    has_and_belongs_to_many :time_tables, dependent: :destroy

    
    validates :name, presence: { message: 'for lecturer blank' }
    validates :email, presence: { message: 'for lecturer blank' }
end
