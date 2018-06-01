class AddNameToDoctors < ActiveRecord::Migration[5.1]
  def change
    add_column :doctors, :name, :string
    add_column :doctors, :specialist, :string
  end
end
