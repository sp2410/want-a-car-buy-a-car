class AddCouponstoRepairshops < ActiveRecord::Migration
  def change
  	add_reference :coupons, :repairshop, foreign_key: true
  end
end
