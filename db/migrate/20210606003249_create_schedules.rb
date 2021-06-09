class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules, id: :uuid do |t|
      t.references :time_table, type: :uuid, foreign_key: true
      t.float :fitness
	    t.integer :conflicts
      t.timestamps
    end
  end
end
