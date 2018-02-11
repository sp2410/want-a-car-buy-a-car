class Addlogoheroimagetouser < ActiveRecord::Migration
  def change
  	add_column :users, :backgroundimage, :string
  	add_column :users, :logoimage, :string  	
  	add_column :users, :websiteheader, :string
  	add_column :users, :websitesubheader, :string
  	add_column :users, :websitedescription, :string
  end
end
