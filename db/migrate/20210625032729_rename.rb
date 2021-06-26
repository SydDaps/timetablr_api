class Rename < ActiveRecord::Migration[6.1]
  def change
    rename_column :schedule_times, :start_at, :start
    rename_column :schedule_times, :end_at, :end
  end
end
