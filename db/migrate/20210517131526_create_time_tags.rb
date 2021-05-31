class CreateTimeTags < ActiveRecord::Migration[6.1]
  def change
    create_table :time_tags, id: :uuid do |t|
      t.string :name
      t.interval :duration
      t.time :start
      t.time :end
      t.belongs_to :department, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
