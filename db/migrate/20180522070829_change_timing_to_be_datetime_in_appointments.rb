class ChangeTimingToBeDatetimeInAppointments < ActiveRecord::Migration[5.1]
  def change
  	change_column :appointments, :timing, :datetime
  end
end
