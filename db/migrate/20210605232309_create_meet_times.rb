class CreateMeetTimes < ActiveRecord::Migration[6.1]
  def change
    create_table :meet_times, id: :uuid do |t|
      t.references :time_tag, type: :uuid, foreign_key: true
      t.time :start
      t.time :end
      t.timestamps
    end
  end
end
