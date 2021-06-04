class CreateCoursesTimeTags < ActiveRecord::Migration[6.1]
  def change
    create_table :courses_time_tags, id: false do |t|
      t.belongs_to :course, type: :uuid, foreign_key: true
      t.belongs_to :time_tag, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
