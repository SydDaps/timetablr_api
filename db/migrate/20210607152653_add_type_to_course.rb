class AddTypeToCourse < ActiveRecord::Migration[6.1]
  def change
    add_column :courses, :kind, :string
  end
end
