class CreateCourses < ActiveRecord::Migration[6.1]
  def change
    create_table :courses, id: :uuid do |t|
      t.integer :size
      t.string :name
      t.string :code
      t.belongs_to :level,type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
