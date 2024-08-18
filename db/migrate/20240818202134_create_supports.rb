class CreateSupports < ActiveRecord::Migration[7.1]
  def change
    create_table :supports do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
