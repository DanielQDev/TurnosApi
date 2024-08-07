class CreateContracts < ActiveRecord::Migration[7.1]
  def change
    create_table :contracts do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.string :status
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
