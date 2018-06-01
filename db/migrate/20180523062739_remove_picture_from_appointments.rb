class RemovePictureFromAppointments < ActiveRecord::Migration[5.1]
  def change
    remove_column :appointments, :picture, :string
  end
end
