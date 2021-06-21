class CreateCourseSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :course_schedules, id: :uuid do |t|
      t.belongs_to :schedule_time, type: :uuid, foreign_key: true
      t.belongs_to :day, type: :uuid, foreign_key: true
      t.belongs_to :course, type: :uuid, foreign_key: true
    end
  end
end
