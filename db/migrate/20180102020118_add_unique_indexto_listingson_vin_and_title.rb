class AddUniqueIndextoListingsonVinAndTitle < ActiveRecord::Migration
  def change
  	add_index :listings, [:vin, :title], unique: true
  end
end
