class AddAddressToUser < ActiveRecord::Migration
  def change
  	add_column :users, :zipcode, :string
  	add_column :users, :city, :string
  	add_column :users, :state, :string
  	add_column :users, :street_address, :string  	

  	add_column :users, :latitude, :float
  	add_column :users, :longitude, :float

  	add_column :users, :phone_number, :string

  end
end
