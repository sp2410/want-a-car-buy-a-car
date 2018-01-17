class AddNameToUser < ActiveRecord::Migration
  def change
  	add_column :users, :name, :string, :default => "No Name"
  end
end
