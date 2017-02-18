class Chanagedefaultfalse < ActiveRecord::Migration
  def change
  	change_column :listings, :wholesale, :boolean, :default => false

  	# change_column :foos, :myattribute, :string, :default => "value"
   #  Foo.update_all(:myattribute => "value")
  end
end
