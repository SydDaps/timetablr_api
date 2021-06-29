class CreateClassTimeTrackers < ActiveRecord::Migration[6.1]
  def change
    create_table :class_time_trackers, id: :uuid do |t|
      t.belongs_to :day, type: :uuid, foreign_key: true
      t.belongs_to :time_table, type: :uuid, foreign_key: true
      t.belongs_to :schedule_time, type: :uuid, foreign_key: true
      t.belongs_to :level, type: :uuid, foreign_key: true
      t.belongs_to :department, type: :uuid, foreign_key: true
      t.string :course_kind
    end
  end
end
