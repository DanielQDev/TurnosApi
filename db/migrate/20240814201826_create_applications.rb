class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.boolean :is_confirmed
      t.references :user, null: false, foreign_key: true
      t.references :shift, null: false, foreign_key: true

      t.timestamps
    end
  end
end
