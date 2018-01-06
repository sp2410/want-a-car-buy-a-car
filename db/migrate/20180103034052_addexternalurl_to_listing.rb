class AddexternalurlToListing < ActiveRecord::Migration
  def change
  	add_column :listings, :external_url, :boolean, :default => false
  end
end
