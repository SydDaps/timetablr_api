class CreateCoursesAndLecturers < ActiveRecord::Migration[6.1]
  def change
    create_table :courses_lecturers, id: false do |t|
      t.belongs_to :course, type: :uuid, foreign_key: true
      t.belongs_to :lecturer, type: :uuid, foreign_key: true
    end
  end
end
