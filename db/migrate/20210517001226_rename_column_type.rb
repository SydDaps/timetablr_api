class RenameColumnType < ActiveRecord::Migration[6.1]
  def change
    rename_column :time_tables, :type, :kind
  end
end
