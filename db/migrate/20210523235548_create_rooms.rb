class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms, id: :uuid do |t|
      t.string :name
      t.integer :capacity
      t.belongs_to :room_category, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end