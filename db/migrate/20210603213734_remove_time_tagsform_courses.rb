class RemoveTimeTagsformCourses < ActiveRecord::Migration[6.1]
  def change
    remove_reference :courses, :time_tag, null: false, foreign_key: true, type: :uuid
  end
end
