class AddBodyTypeToListings < ActiveRecord::Migration
  def change
    add_column :listings, :bodytype, :string
  end
end
