class AddIsPostulatedToShifts < ActiveRecord::Migration[7.1]
  def change
    add_column :shifts, :is_postulated, :boolean, default: false
  end
end
