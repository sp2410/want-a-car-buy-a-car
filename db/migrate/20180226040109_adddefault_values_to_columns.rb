class AdddefaultValuesToColumns < ActiveRecord::Migration
  def change
  	change_column_default :listings, :bodytype, "NOT LISTED"
  	change_column_default :listings, :city, "NOT LISTED"

  	change_column_default :repairshops, :city, "NOT LISTED"
  	change_column_default :users, :city, "NOT LISTED"
  	
  	change_column_default :repairshops, :state, "NOT LISTED"
  	change_column_default :users, :state, "NOT LISTED"

  	change_column_default :listings, :state, "NOT LISTED"
  	change_column_default :listings, :transmission, "NOT LISTED"
  	change_column_default :listings, :newused, "U"
  	change_column_default :listings, :cylinder, "NOT LISTED"
  	change_column_default :listings, :fuel, "NOT LISTED"
  	change_column_default :listings, :drive, "NOT LISTED"
  	change_column_default :listings, :year, 0

  end
end
