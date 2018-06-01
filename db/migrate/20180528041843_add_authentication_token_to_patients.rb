class AddAuthenticationTokenToPatients < ActiveRecord::Migration[5.1]
  def change
  	add_column :patients, :authentication_token, :string
    add_index :patients, :authentication_token, unique: true
  end
end
