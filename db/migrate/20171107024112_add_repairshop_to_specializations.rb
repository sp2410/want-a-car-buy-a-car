class AddRepairshopToSpecializations < ActiveRecord::Migration
  def change
    add_reference :specializations, :repairshop, index: true, foreign_key: true
  end
end
