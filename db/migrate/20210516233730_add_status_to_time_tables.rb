class AddStatusToTimeTables < ActiveRecord::Migration[6.1]
  def change
    add_column :time_tables, :status, :string
  end
end
