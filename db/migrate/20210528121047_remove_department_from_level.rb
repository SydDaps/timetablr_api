class RemoveDepartmentFromLevel < ActiveRecord::Migration[6.1]
  def change
    remove_reference :levels, :department, null: false, foreign_key: true, type: :uuid
    add_reference :levels, :time_table, null: false, foreign_key: true, type: :uuid
    remove_column :levels, :size 
  end
end
