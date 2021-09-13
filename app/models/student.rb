class Student < ApplicationRecord
  belongs_to :level
  belongs_to :department

  has_and_belongs_to_many :time_tables
end
