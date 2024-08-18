class CreateShifts < ActiveRecord::Migration[7.1]
  def change
    create_table :shifts do |t|
      t.datetime :start_hour
      t.datetime :end_hour
      t.string :week
      t.references :schedule, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
