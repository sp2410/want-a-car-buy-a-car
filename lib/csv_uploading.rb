require "open-uri"

module CsvUploading

  def self.picture_from_url(url)
    open(url)
  end

  	MAP = {

  		"user_id" => :user_id,
  		"NewUsed" => :newused,
  		"VIN"	=> :vin,
  		"StockNumber"	 => :stocknumber,
  		"Model"	=> :model,
  		"year"	=> :year,
  		"Trim"	=> :trim,
  		"miles"	=> :miles,
  		"EnginerDescription"	=> :enginedescription,
  		"cylinder"	=> :cylinder,
  		"fuel"	=> :fuel,
  		"transmission" => :transmission,	
  		"price" => :price,
  		"color"	 => :color ,
  		"InteriorColor"	=> :interiorcolor,
  		"Options" => :options,
  		"description" => :description,
      "image" => :all_images

  	}

  	
end


