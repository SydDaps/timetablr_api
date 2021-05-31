class CreateTimeTables < ActiveRecord::Migration[6.1]
  def change
    create_table :time_tables, id: :uuid do |t|
      t.string :name
      t.string :type
      t.string :category
      t.references :user, type: :uuid, foreign_key: true
      t.timestamps
    end
  end
end
