class AddYearAndMilesAndTransmissionAndColorAndCylinderToListings < ActiveRecord::Migration
  def change
    add_column :listings, :year, :integer    
    add_column :listings, :miles, :integer
    add_column :listings, :transmission, :string
    add_column :listings, :color, :string
    add_column :listings, :cylinder, :string
  end
end
