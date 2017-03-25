class AddNewOrUsed < ActiveRecord::Migration
  def change
  	add_column :listings, :NewUsed, :string
  	add_column :listings, :VIN, :string
	add_column :listings, :StockNumber, :string
	add_column :listings, :Model, :string
	add_column :listings, :Trim, :string
	add_column :listings, :EnginerDescription, :string
	add_column :listings, :InteriorColor, :string
	add_column :listings, :Options, :string
  end
end
