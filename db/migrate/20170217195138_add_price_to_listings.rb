class AddPriceToListings < ActiveRecord::Migration
  def change
    add_column :listings, :price, :integer, :default => 0
  end
end
