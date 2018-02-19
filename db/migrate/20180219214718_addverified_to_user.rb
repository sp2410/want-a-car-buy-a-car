class AddverifiedToUser < ActiveRecord::Migration
  def change
  	add_column :users, :verified, :boolean, :default => false
  	add_column :users, :tdcfinance, :boolean, :default => false
  end
end
