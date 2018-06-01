class AddPictureToAppointments < ActiveRecord::Migration[5.1]
  def change
    add_column :appointments, :picture, :string
  end
end
