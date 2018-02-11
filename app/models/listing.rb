require 'csv_uploading' 
require 'csv'
require 'active_record'
require 'activerecord-import'
require 'activerecord-import/base'


class Listing < ActiveRecord::Base
	#attr_accessor :user
	include CsvUploading

	# attr_accessor :remote

	# def initialize(input = {})
	# 	@remote = input[:remote] || false
	# 	super
	# end


	belongs_to :category
	belongs_to :subcategory
	belongs_to :user
	validates_uniqueness_of :vin
	validates_presence_of :title	



	#validates :user_id, presence: true
	
	# validates_presence_of :title
	# validates_presence_of :city
	# validates_presence_of :state
	# validates_presence_of :description


	# if :external_url == false
	# 	puts "hello I am here"
	# 	puts "*************"
	# 	puts "*************"
	# 	puts "*************"
	# 	puts "*************"

		mount_uploader :image, ImageUploader
		mount_uploader :imagefront, ImageUploader
		mount_uploader :imageback, ImageUploader
		mount_uploader :imageleft, ImageUploader
		mount_uploader :imageright, ImageUploader
		mount_uploader :frontinterior, ImageUploader
		mount_uploader :rearinterior, ImageUploader
	# end


	geocoded_by :full_address
	after_validation :geocode

	scope :approved_all, -> {joins(:user).where('users.role = ?', 6).where(approved: true)}

	
	scope :approved_wholesale, -> {joins(:user).where('users.role = ?', 6).where(approved: true).where(wholesale: true)}

	# scope :approved_wholesale, -> {where(approved: true).where(wholesale: true).where('users.role = ?', 6)}

	scope :approved_used, -> {joins(:user).where('users.role = ?', 6).where(approved: true).where(newused: "U")}

	scope :approved_new, -> {joins(:user).where('users.role = ?', 6).where(approved: true).where(newused: "N")}

	# scope

	scope :wholesale_listings, -> {joins(:user).where('users.role = ?', 6).where(approved: true).where(wholesale: true)}

	# scope :approved_wholesale, -> {where(approved: true).where(wholesale: true).where('users.role = ?', 6)}

	scope :used_listings, -> {joins(:user).where('users.role = ?', 6).where(approved: true).where(newused: "U")}

	scope :new_listings, -> {joins(:user).where('users.role = ?', 6).where(approved: true).where(newused: "N")}
	

	scope :wholesale_listings, -> {joins(:user).where(wholesale: true)}

	scope :expired_listings, -> {where('expiration_date <= ?', DateTime.now)}

	scope :not_approved, -> {where('approved = ?', false)}
	

	scope :diamond_dealer_listings, -> {joins(:user).where('users.role = ?', 6)}
	scope :basic_dealer_listings, -> {joins(:user).where('users.role = ?', 1)}
	scope :silver_dealer_listing, ->{joins(:user).where('users.role = ?', 3)}
	scope :gold_dealer_listing, ->{joins(:user).where('users.role = ?', 4)}
	scope :basic_user_listing, ->{joins(:user).where('users.role = ?', 0)}


	scope :other_approved_used, -> {joins(:user).where(approved: true).where(newused: "U")}

	scope :other_approved_new, -> {joins(:user).where(approved: true).where(newused: "N")}

	scope :other_wholesale_listings, -> {joins(:user).where(approved: true).where(wholesale: true)}


	
	#facets

	scope :listing_search_cities, -> {unscoped.group(:city).count}
	scope :listing_search_body_type, -> {unscoped.group(:bodytype).count}
	scope :listing_search_states, -> {unscoped.group(:state).count}
	scope :listing_search_newused, -> {unscoped.group(:NewUsed).count}
	scope :listing_search_transmission, -> {unscoped.group(:transmission).count}
	scope :listing_search_cylinder, -> {unscoped.group(:cylinder).count}
	scope :listing_search_fuel, -> {unscoped.group(:fuel).count}
	scope :listing_search_drive, -> {unscoped.group(:drive).count}
	scope :listing_search_trim, -> {unscoped.group(:trim).count}
	scope :listing_search_color, -> {unscoped.group(:color).count}
	scope :listing_search_year, -> {unscoped.group(:year).count}
	scope :listing_search_interiorcolor, -> {unscoped.group(:interiorcolor).count}



	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |l|
				csv << l.attributes.values_at(*column_names)
			end
		end
	end	


	def self.import_listings(file)	
		start = Time.now	
		count = 0
		valid_listings = Array.new
		data = {}
		users = User.all.as_json
		user_hash = Hash.new

		users.each do |i|
			user_hash[i["id"]] = i
		end

		map = {

	  		"user_id" => :user_id,      
	  		"NewUsed" => :newused,
	  		"VIN"	=> :vin,
	  		"StockNumber"	 => :stocknumber,
	      "BodyType" => :bodytype,
	      "Make" => :make,
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
	      "InteriorColor" => :interiorcolor,
	  		"ExteriorColor"	=> :color,
	  		"Options" => :options,
	  		"description" => :description,
	      "image" => :all_images

  		}

		# p user_hash
		# p "*******************************"
		# p "*******************************"


		# p Listing.count
		# p Listing.delete_all
		# p "problem is here 1"
		CSV.foreach(file, headers: true, encoding:'iso-8859-1:utf-8') do |row|
			#Use create when you dont need customization with the listing	

		# p "problem is here 2"

			# p row.to_hash["Make"]
			
			row.to_hash.each do |k, v|
				key = map[k]
				data[key] = v

				# p "problem is here 3"

			end

			unless data[:vin] == nil

				# p "problem is here 4"				
				listing =  Listing.new

				#listing.attributes = (row.to_hash).merge(image: URI.parse(row['image'])) #			
				listing.title = "#{data[:year] if data[:year]} #{data[:make] if data[:make]} #{data[:model] if data[:model]}"
				user = user_hash[data[:user_id].to_i]

				# p "*******************************"
				# p "*******************************"

				# p user

				# p user
				# p "*******************************"
				# p "*******************************"


				if user != nil
					listing.city = user["city"]

					# p user["city"]
					# p "*******************************"
					# p "*******************************"


					listing.state = user["state"]
					listing.zipcode = user["zipcode"] 
					listing.latitude = user["latitude"].to_f
					listing.longitude = user["longitude"].to_f
				end

				# listing.approved = true

				# # p data[:all_images]
				# p "*******************************"
				# p "*******************************"

				# p data[:make]
				
				data[:approved] = true

				

				# listing.attributes = .merge(user_id: current_user.id).merge(category_id: row["category"]).merge(subcategory_id: row["subcategory"])
				# p data
				begin
					# p data.except(:all_images)
					# p data
					listing.attributes = data.slice(:user_id, :newused, :vin, :stocknumber, :bodytype, :make, :model, :year, :trim, :miles, :enginedescription, :cylinder, :fuel, :transmission, :price, :color , :interiorcolor, :color, :options, :description, :approved)

					unless data[:all_images] == nil



					listing_images = data[:all_images].split((/[|,]+/))
						# i = 0
					
						# [:image, :imagefront, :imageback, :imageleft, :imageright, :frontinterior, :rearinterior].each do |image|				
							unless listing_images.size < 1
								# p listing_images[i]

								listing.external_image = listing_images[0]
								listing.external_imagefront = listing_images[1] if listing_images[1]
								listing.external_imageback = listing_images[2] if listing_images[2]
								listing.external_imageleft = listing_images[3] if listing_images[3]
								listing.external_imageright = listing_images[4] if listing_images[4]
								listing.external_frontinterior = listing_images[5] if listing_images[5]
								listing.external_rearinterior = listing_images[6] if listing_images[6]							
								# p data[image]
								# i += 1
							end
							# p "hello"
						# end

					end

					listing.external_url = true
					listing.approved = true

					# p listing.approved

					#listing.attributes = (row.to_hash).merge(user_id: current_user.id) #
					data.delete(:all_images)


					# p listing

					# return false unless listing.valid?
					# p listing

					# if listing.valid?
						#Listing.create!((row.to_hash).merge(user_id: current_user.id))
					valid_listings << listing				
						# p "here"
						# if listing.save!
						
						# 	# p listing
						# end									
					# end

					data.clear

				rescue Exception => e
					
				end
				


				
				# p "*******************************"
				# p "*******************************"

				

				#listing = Listing.where(:vin => row["Vin"]).first_or_create(row.to_hash).merge(user_id: current_user.id)
			 	#Otherwise use new as shown below

			 	# listing = find_by_id(row["vin"]) || new			 	
			 	# listing.attributes = row.to_hash.slice()
			 	# listing.user = current_user
			 	# listing.save		 
			end
		end

		# p "problem is here 2"p valid_listings
		# 

		count = valid_listings.size

		# begin
			# p valid_listings
			# Listing.import valid_listings, on_duplicate_key_update: { conflict_target: [:title], columns: [:user_id, :newused, :stocknumber, :model, :year, :trim, :miles, :enginedescription,:cylinder,:fuel,:transmission,  :price, :color, :interiorcolor, :options, :description,:city, :state, :zipcode, :approved]}
			Listing.import valid_listings, on_duplicate_key_update: [:user_id, :newused, :stocknumber, :model, :year, :trim, :miles, :enginedescription,:cylinder,:fuel,:transmission,  :price, :color, :interiorcolor, :options, :description,:city, :state, :zipcode, :approved]
			# }
			# p Listing.count
			# p Listing.all
		# rescue
		# 	p "some issue"
		# end

		finish = Time.now
		puts diff = finish - start
		count == 0 ? false : count		
		# p self.last
	end

	# def self.import_listings(file)	
	# 	start = Time.now	
	# 	count = 0
	# 	valid_listings = Array.new
	# 	current_listings = Listing.all.pluck(:vin).map{|x| [x, 1]}.to_h
	# 	# p Listing.delete_all
	# 	options = {:chunk_size => 100, :key_mapping => MAP}
	# 	old_listings = Array.new
	# 	new_listings = Array.new

	# 	n = SmarterCSV.process(file, options) do |chunk|			

	# 		chunk.each do |i|	
	# 			if current_listings.key?(i[:vin])
	# 				old_listings << i 
	# 			else
	# 				new_listings << i
	# 			end
	# 		end
	# 		# Listing.collection.insert(chunk) 
	# 		# p chunk
	# 		Listing.create(new_listings)
	# 		# Listing.update(old_listings)
	# 		p new_listings
	# 		p old_listings

	# 		old_listings.clear
	# 		new_listings.clear
	# 	end



	# 	# 	data = {}

	# 	# 	row.to_hash.each do |k, v|
	# 	# 		key = MAP[k]
	# 	# 		data[key] = v
	# 	# 	end

	# 	# 	unless data[:vin] == nil


	# 	# 		listing =  Listing.new

	# 	# 		#listing.attributes = (row.to_hash).merge(image: URI.parse(row['image'])) #			
	# 	# 		listing.title = "#{data[:year]} #{data[:make]} #{data[:model]}"
	# 	# 		user = User.find_by_id(data[:user_id])

	# 	# 		# p "*******************************"
	# 	# 		# p "*******************************"

	# 	# 		# p user
	# 	# 		if user != nil
	# 	# 			listing.city = user.city 
	# 	# 			listing.state = user.state 
	# 	# 			listing.zipcode = user.zipcode 
	# 	# 		end

	# 	# 		listing.approved = true

	# 	# 		# # p data[:all_images]
	# 	# 		# p "*******************************"
	# 	# 		# p "*******************************"

				

	# 	# 		unless data[:all_images] == nil



	# 	# 			listing_images = data[:all_images].split(",")
	# 	# 			i = 0
				
	# 	# 			[:image, :imagefront, :imageback, :imageleft, :imageright, :frontinterior, :rearinterior].each do |image|				
	# 	# 				unless listing_images.size < 1
	# 	# 					data[image] = CsvUploading::picture_from_url(listing_images[i])
	# 	# 					i += 1
	# 	# 				end
	# 	# 				# p "hello"
	# 	# 			end

	# 	# 		end

	# 	# 		#listing.attributes = (row.to_hash).merge(user_id: current_user.id) #
	# 	# 		data.delete(:all_images)

	# 	# 		# listing.attributes = .merge(user_id: current_user.id).merge(category_id: row["category"]).merge(subcategory_id: row["subcategory"])
	# 	# 		# p data
	# 	# 		listing.attributes = data

	# 	# 		# return false unless listing.valid?
	# 	# 		p listing

	# 	# 		if listing.valid?
	# 	# 			#Listing.create!((row.to_hash).merge(user_id: current_user.id))
	# 	# 			valid_listings << listing
	# 	# 			# if listing.save!
	# 	# 			count = count+1
	# 	# 				# p listing
	# 	# 			# end									
	# 	# 		end

				

	# 	# 		# p "*******************************"
	# 	# 		# p "*******************************"

				

	# 	# 		#listing = Listing.where(:vin => row["Vin"]).first_or_create(row.to_hash).merge(user_id: current_user.id)
	# 	# 	 	#Otherwise use new as shown below

	# 	# 	 	# listing = find_by_id(row["vin"]) || new			 	
	# 	# 	 	# listing.attributes = row.to_hash.slice()
	# 	# 	 	# listing.user = current_user
	# 	# 	 	# listing.save		 
	# 	# 	 end
	# 	# end

	# 	# # p "problem is here 2"
	# 	# Listing.import valid_listings, on_duplicate_key_update: { conflict_target: [:vin],
	# 	# 	columns: [:user_id, :newused, :stocknumber, :model, :year, :trim, :miles, :enginedescription,:cylinder,:fuel,:transmission,  :price, :color, :interiorcolor, :options, :description, :image, :image, :imagefront, :imageback, :imageleft, :imageright, :frontinterior, :rearinterior]
	# 	# }

	# 	# finish = Time.now
	# 	# puts diff = finish - start
	# 	# count == 0 ? false : count		
	# end

	def self.incrementcount(count)
		count = count+1
		return count
	end

	def returnthecount(count)
		return count
	end


	def full_address
		[city, state, zipcode].join(', ')
	end

	def minprice(price)		
		price.to_i - 10000
	end

	def maxprice(price)
		price.to_i + 10000
	end


	def self.search(params)
		if params
			listings = Listing.where(approved: true).where('expiration_date > ?', DateTime.now)
			listings = listings.where('LOWER(listings.make) like ?', "%#{params[:category].downcase}%") if params[:category].present?
			listings = listings.where('LOWER(listings.model) like ?',"%#{params[:subcategory].downcase}%") if params[:subcategory].present?
			listings = listings.where("listings.newused = '#{params[:NewUsed][0].upcase}'") if params[:NewUsed].present?
			listings = listings.where("price >= ?", "#{params[:minprice]}") if params[:minprice].present?			
			listings = listings.where("price <= ?", "#{params[:maxprice]}") if params[:maxprice].present?			


			listings = listings.where('LOWER(listings.bodytype) like ?', "%#{params[:bodytype].downcase}%") if params[:bodytype].present?
					
			
			# Listing.where(id: repairshop.near(params[:location], params[:radius]).map{|i| i.id})


			if params[:radius].present?
				listings = Listing.where(id: listings.near(params[:location],params[:radius]).map{|i| i.id}) if params[:location].present?
			else
				listings = Listing.where(id: listings.near(params[:location],200).map{|i| i.id}) if params[:location].present?
			end

			

			# listings.uniq
			listings



		else

			
			all
		end

	end


	# def self.search(params) 
	# 	__elasticsearch__.search( 
	# 	{ 
	# 		query: { 
	# 			multi_match: { 
	# 				query: "#{params[:category].downcase if params[:category].present}", 
	# 				fields: ['make'] 
	# 				} 
	# 			}, 
	# 			multi_match: { 
	# 				query: "#{params[:subcategory].downcase}", 
	# 				fields: ['model'] 
	# 				} 
	# 			},
	# 			multi_match: { 
	# 				query: "#{params[:NewUsed.downcase}", 
	# 				fields: ['model'] 
	# 				} 
	# 			},
	# 	} 
	# 	end 
	# end



	def self.bodysearch(params)
		if params
			listings = Listing.all
			listings = listings.where("bodytype like '#{params[:bodytype].downcase}'") if params[:bodytype].present?			
			listings = listings.where("listings.nwused = '#{params[:NewUsed][0].upcase}'") if params[:NewUsed].present?
			listings = listings.where("price >= ?", "#{params[:minprice]}") if params[:minprice].present?			
			listings = listings.where("price <= ?", "#{params[:maxprice]}") if params[:maxprice].present?			
					

			if params[:radius].present?
				listings = listings.near(params[:location],params[:radius]) if params[:location].present?
			else
				listings = listings.near(params[:location],200) if params[:location].present?
			end

			listings

		else
			all
		end

	end

	

	

end



