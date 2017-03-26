class Fixnames < ActiveRecord::Migration
  def change
  	change_table :listings do |t|
	  	t.rename :NewUsed, :newused
	  	t.rename :VIN, :vin
	  	t.rename :StockNumber, :stocknumber
	  	t.rename :Model, :model
	  	t.rename :Trim, :trim
	  	t.rename :EnginerDescription, :enginedescription
	  	t.rename :InteriorColor, :interiorcolor
	  	t.rename :Options, :options
  	end
  end
end
