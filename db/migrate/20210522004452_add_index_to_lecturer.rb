class AddIndexToLecturer < ActiveRecord::Migration[6.1]
  def change
    add_index :lecturers, :email, unique:  true 
  end
end
