class RemoveDepartmentFromTimetags < ActiveRecord::Migration[6.1]
  def change
    remove_reference :time_tags, :department, null: false, foreign_key: true, type: :uuid
    add_reference :time_tags, :time_table, null: false, foreign_key: true, type: :uuid
  end
end
