class Addwholesaletolisting < ActiveRecord::Migration
 def change
    add_column :listings, :wholesale, :boolean, :default => false
  end
end
