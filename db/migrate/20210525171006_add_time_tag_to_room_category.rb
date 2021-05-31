class AddTimeTagToRoomCategory < ActiveRecord::Migration[6.1]
  def change
    add_reference :room_categories, :time_tag, foreign_key: true, type: :uuid
  end
end
