class StudentsTimeTables < ActiveRecord::Migration[6.1]
  def change
    create_table :students_time_tables, id: false do |t|
      t.belongs_to :student, type: :uuid
      t.belongs_to :time_table, type: :uuid
      t.timestamps
    end
    
  end
end
