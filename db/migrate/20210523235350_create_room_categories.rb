class CreateRoomCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :room_categories, id: :uuid do |t|
      t.string :name
      t.belongs_to :time_table, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end