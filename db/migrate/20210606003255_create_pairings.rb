class CreatePairings < ActiveRecord::Migration[6.1]
  def change
    create_table :pairings, id: :uuid do |t|
      t.belongs_to :schedule, type: :uuid, foreign_key: true
      t.belongs_to :course, type: :uuid, foreign_key: true
      t.belongs_to :meet_time, type: :uuid, foreign_key: true
      t.belongs_to :day, type: :uuid, foreign_key: true
      t.belongs_to :room, type: :uuid, foreign_key: true
      t.belongs_to :time_tag, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
