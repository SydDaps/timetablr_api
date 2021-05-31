class CreateDepartments < ActiveRecord::Migration[6.1]
  def change
    create_table :departments, id: :uuid do |t|
      t.string :name
      t.string :code
      t.belongs_to :time_table,type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
