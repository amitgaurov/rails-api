class AddPictureToPatients < ActiveRecord::Migration[5.1]
  def change
    add_column :patients, :picture, :string
  end
end
