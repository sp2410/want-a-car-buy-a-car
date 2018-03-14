class AddBackgroundToTitle < ActiveRecord::Migration
  def change
  	add_column :users, :textbackgroundcolor, :string, :default => "0,0,0"
  end
end
