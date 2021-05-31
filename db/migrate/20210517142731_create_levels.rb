class CreateLevels < ActiveRecord::Migration[6.1]
  def change
    create_table :levels, id: :uuid do |t|
      t.string :code
      t.integer :size
      t.belongs_to :department,type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
