class CreateLecturersTimeTables < ActiveRecord::Migration[6.1]
  def change
    create_table :lecturers_time_tables, id: false do |t|
      t.belongs_to :lecturer, type: :uuid
      t.belongs_to :time_table, type: :uuid
      t.timestamps
    end
  end
end
