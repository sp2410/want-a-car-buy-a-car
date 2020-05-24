require 'csv'
require 'open-uri'

class UpdateData
	attr_accessor :arr, :headers_hash

	def initialize
		@arr = Array.new
		@headers_hash = {
				"dealerid" => :user_id,
				"condition" => :newused,
				"vin"	=> :vin,
				"body_type" => :bodytype,
				"make" => :make,
				"model"	=> :model,
				"year"	=> :year,
				"mileage"	=> :miles,
				"drivetype" => :enginedescription,
				"cylinder"	=> :cylinder,
				"fuel_type"	=> :fuel,
				"transmission" => :transmission,
				"price" => :price,
				"interior_color" => :interiorcolor,
				"color"	=> :color,
				"features" => :options,
				"description" => :description,
				"photos" => :all_images,
			}
	end

	def read_from_file
			csv_text = URI.open('http://datain.v12software.com/35388/4/arizonaautogroup.txt')
			csv = CSV.new(csv_text, :headers=>true, encoding:'iso-8859-1:utf-8', :col_sep => "|", liberal_parsing: true)
			csv.each do |row|
				data = {}
				row.to_hash.each do |k, v|
					key = headers_hash[k]
					data[key] = v if key
				end

				unless data[:vin] == nil
					data[:user_id] = fetch_internal_id[data[:user_id]]
					data[:title] = "#{data[:year] if data[:year]} #{data[:make] if data[:make]} #{data[:model] if data[:model]}"
						unless data[:all_images] == nil
							listing_images = data[:all_images].split((/[|,]+/))
								unless listing_images.size < 1
									data[:external_image] = listing_images[0]
									data[:external_imagefront] = listing_images[1] if listing_images[1]
									data[:external_imageback] = listing_images[2] if listing_images[2]
									data[:external_imageleft] = listing_images[3] if listing_images[3]
									data[:external_imageright] = listing_images[4] if listing_images[4]
									data[:external_frontinterior] = listing_images[5] if listing_images[5]
									data[:external_rearinterior] = listing_images[6] if listing_images[6]
								end
						end

						data[:external_url] = true
						data[:approved] = true
						data.delete(:all_images)
						data.delete :age
						data[:price] = "0" if data[:price].length > 6
						@arr << data
				end
			end
	end

	def update_listing_from_array
		@arr.each do |i|
			begin
				Listing.create_or_update(i)
			rescue
				puts "issue with #{i}"
			end
		end
	end

	def fetch_internal_id
		{
			"38451" => 	"1140",
			"38449" => 	"1148",
			"38446" => 	"1149",
			"38447" => 	"1152",
			"38452" =>	"1142",
			"38767" => "1150",
		}
	end

	def update_location
		Listing.where(:user_id => 1152).update_all(:city => "Mesa", :state => "AZ", :latitude => "33.4151117", :longitude => "-111.8314773", :zipcode => "85210")
		Listing.where(:user_id => 1140).update_all(:city => "Mesa", :state => "AZ", :latitude => "33.4151117", :longitude => "-111.8314773", :zipcode => "85210")
		Listing.where(:user_id => 1149).update_all(:city => "Phoenix", :state => "AZ", :latitude => "33.4485866", :longitude => "-112.0773456", :zipcode => "85009")
		Listing.where(:user_id => 1148).update_all(:city => "Tempe", :state => "AZ", :latitude => "33.4255056", :longitude => "-111.9400125", :zipcode => "85284")
		Listing.where(:user_id => 1145).update_all(:city => "Mesa", :state => "AZ", :latitude => "33.4151117", :longitude => "-111.8314773", :zipcode => "85020")
		Listing.where(:user_id => 1142).update_all(:city => "Scottsdale", :state => "AZ", :latitude => "33.5091215", :longitude => "-111.8992365", :zipcode => "85257")
		Listing.where(:user_id => 1150).update_all(:city => "Phoenix", :state => "AZ", :latitude => "33.4485866", :longitude => "-112.0773456", :zipcode => "85009")

		Listing.update_all(:newused => "U")

		Listing.remove_unwanted_listings
	end
end