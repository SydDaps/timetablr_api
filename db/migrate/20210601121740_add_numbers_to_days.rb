class AddNumbersToDays < ActiveRecord::Migration[6.1]
  def change
    add_column :days, :number, :string
  end
end
