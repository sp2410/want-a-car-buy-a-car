class Adduseridandgps < ActiveRecord::Migration
  def change
  	add_column :repairshops, :latitude, :float
  	add_column :repairshops, :longitude, :float
  	add_reference :repairshops, :user, index: true
  	add_column :repairshops, :image, :string  	
  end
end
