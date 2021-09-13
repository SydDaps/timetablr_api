class CreateStudents < ActiveRecord::Migration[6.1]
  def change
    create_table :students, id: :uuid do |t|
      t.references :level, null: false, foreign_key: true, type: :uuid
      t.references :department, null: false, foreign_key: true, type: :uuid
      t.string :email
      t.timestamps
    end
  end
end
