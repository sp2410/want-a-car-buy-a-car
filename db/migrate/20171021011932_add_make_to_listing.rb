class AddMakeToListing < ActiveRecord::Migration
  def change
    add_column :listings, :make, :string
  end
end
