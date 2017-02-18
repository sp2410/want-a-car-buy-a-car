class AddFuelAndDriveToListings < ActiveRecord::Migration
  def change
    add_column :listings, :fuel, :string    
    add_column :listings, :drive, :string
  end
end
