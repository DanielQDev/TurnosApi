class CreateShifts < ActiveRecord::Migration[7.1]
  def change
    create_table :shifts do |t|
      t.datetime :start_hour, null: false
      t.datetime :end_hour, null: false
      t.boolean :is_confirmed, default: false
      t.references :user, null: false, foreign_key: true
      t.references :schedule, null: false, foreign_key: true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
