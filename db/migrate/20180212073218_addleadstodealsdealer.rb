class Addleadstodealsdealer < ActiveRecord::Migration
  def change
  	add_column :users, :leads2dealscustomer, :boolean, :default => false
  end
end
