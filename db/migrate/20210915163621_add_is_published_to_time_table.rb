class AddIsPublishedToTimeTable < ActiveRecord::Migration[6.1]
  def change
    add_column :time_tables, :is_published, :boolean
  end
end
