class AddNameToPatients < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :name, :string
    add_column :patients, :address, :string
    add_column :patients, :age, :integer
  end
end
