class RemaneTimeTagColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :time_tags, :start, :start_at
    rename_column :time_tags, :end, :end_at
  end
end
