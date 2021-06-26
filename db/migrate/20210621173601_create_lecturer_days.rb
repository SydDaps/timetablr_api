class CreateLecturerDays < ActiveRecord::Migration[6.1]
  def change
    create_table :lecture_schedules, id: :uuid do |t|
      t.belongs_to :schedule_time, type: :uuid, foreign_key: true
      t.belongs_to :day, type: :uuid, foreign_key: true
      t.belongs_to :lecturer, type: :uuid, foreign_key: true
      t.belongs_to :time_table, type: :uuid, foreign_key: true
    end
  end
end
