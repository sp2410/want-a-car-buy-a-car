class AddExternalImagesToListings < ActiveRecord::Migration
  def change
  	add_column :listings, :external_image, :string
  	add_column :listings, :external_imagefront, :string
  	add_column :listings, :external_imageback, :string
  	add_column :listings, :external_imageleft, :string
  	add_column :listings, :external_imageright, :string
  	add_column :listings, :external_frontinterior, :string
  	add_column :listings, :external_rearinterior, :string
  end
end
