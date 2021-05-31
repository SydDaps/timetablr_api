class RemoveRoomCategoryFromRooms < ActiveRecord::Migration[6.1]
  def change
    remove_reference :rooms, :room_category, null: false, foreign_key: true, type: :uuid
    add_reference :rooms, :time_table, null: false, foreign_key: true, type: :uuid
  end
end
