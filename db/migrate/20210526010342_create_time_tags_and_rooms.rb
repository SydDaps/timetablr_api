class CreateTimeTagsAndRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms_time_tags, id: false do |t|
      t.belongs_to :time_tag, type: :uuid
      t.belongs_to :room, type: :uuid
      t.timestamps
    end
  end
end
