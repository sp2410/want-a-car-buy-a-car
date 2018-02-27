class AddTextColorToUser < ActiveRecord::Migration
  def change
  	add_column :users, :textcolor, :string, :default => "white"
  end
end
