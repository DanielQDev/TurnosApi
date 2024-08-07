class CreateSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :schedules do |t|
      t.datetime :start_hour
      t.datetime :end_hour
      t.integer :duration
      t.boolean :weekend
      t.references :contract, null: false, foreign_key: true

      t.timestamps
    end
  end
end
