class Changedefaultcolumns < ActiveRecord::Migration
  def change  	
  	change_column_default :listings, :transmission, "AUTOMATIC"  	  	
  	change_column_default :listings, :fuel, "GASOLINE"
  	change_column_default :listings, :drive, "2WD"
  end
end
