class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :first_name
      t.string :last_name
      t.string :password_digest, null: false
      t.string :role, default: 'engineer'
      t.string :color

      t.timestamps
    end
  end
end
