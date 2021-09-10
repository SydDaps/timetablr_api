class User < ApplicationRecord
    has_secure_password
    validates :name, presence: true
    validates :email, presence: true
    validates :password_confirmation, presence: true

    has_many :time_tables, dependent: :destroy
end
