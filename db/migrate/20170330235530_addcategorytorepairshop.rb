class Addcategorytorepairshop < ActiveRecord::Migration
  def change
  	add_reference :repairshops, :category, index: true
  end
end
