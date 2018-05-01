class Addbhphcustomertouser < ActiveRecord::Migration
  def change
  	add_column :users, :bhphcustomer, :boolean, :default => false
  end
end
