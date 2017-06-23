class Addpicturestolisting < ActiveRecord::Migration
  def change
  	add_column :listings, :imagefront, :string
  	add_column :listings, :imageback, :string
  	add_column :listings, :imageleft, :string
  	add_column :listings, :imageright, :string
  	add_column :listings, :frontinterior, :string
  	add_column :listings, :rearinterior, :string
  end
end


