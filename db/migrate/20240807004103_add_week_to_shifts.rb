class AddWeekToShifts < ActiveRecord::Migration[7.1]
  def change
    add_column :shifts, :week, :string
  end
end
