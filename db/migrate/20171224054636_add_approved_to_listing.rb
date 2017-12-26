class AddApprovedToListing < ActiveRecord::Migration
  def change
    add_column :listings, :approved, :boolean, :default => false
    add_column :repairshops, :approved, :boolean, :default => false
  end
end
