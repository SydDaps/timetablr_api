class CreateTagDays < ActiveRecord::Migration[6.1]
  def change
    create_table :days_time_tags, id: false do |t|
      t.belongs_to :day, type: :uuid, foreign_key: true
      t.belongs_to :time_tag, type: :uuid, foreign_key: true
    end
  end
end
