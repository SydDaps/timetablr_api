class AddTimeTagToCourses < ActiveRecord::Migration[6.1]
  def change
    add_reference :courses, :department, null: false, foreign_key: true, type: :uuid
    add_reference :courses, :time_table, null: false, foreign_key: true, type: :uuid
    remove_column :courses, :size, :string
  end
end
