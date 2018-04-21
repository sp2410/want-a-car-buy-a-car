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

	# def to_param
	#     "#{id}-#{title}".parameterize
	#  end



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

	# scope :listing_search_cities, -> {group('created_at, city').count}
	# scope :listing_search_body_type, -> {group('created_at, bodytype').count}
	# #scope :listing_search_states, -> {group('created_at, state').count}
	# scope :listing_search_newused, -> {group('created_at, newused').count}
	# scope :listing_search_transmission, -> {group('created_at, transmission').count}
	# scope :listing_search_cylinder, -> {group('created_at, cylinder').count}
	# scope :listing_search_fuel, -> {group('created_at, fuel').count}
	# scope :listing_search_drive, -> {group('created_at, drive').count}
	# scope :listing_search_trim, -> {group('created_at, trim').count}
	# scope :listing_search_color, -> {group('created_at, color').count}
	# scope :listing_search_year, -> {group('created_at, year').count}
	# scope :listing_search_interiorcolor, -> {group('created_at, interiorcolor').count}



    def self.listing_search_cities(listings)
      return {} if listings.size < 1

      final_hash = Hash.new

      listings.each do |listing|
        city = listing.city
        if final_hash.has_key?(city)
          final_hash[city] += 1
        else
          final_hash[city] = 1
        end
      end

      return final_hash
    end


    def self.listing_search_states(listings)
      return {} if listings.size < 1

      final_hash = Hash.new

      listings.each do |listing|
        state = listing.state
        if final_hash.has_key?(state)
          final_hash[state] += 1
        else
          final_hash[state] = 1
        end
      end

      return final_hash
    end


 def self.listing_search_body_type(listings)
      return {} if listings.size < 1

      final_hash = Hash.new

      listings.each do |listing|
        state = listing.bodytype
        if final_hash.has_key?(state)
          final_hash[state] += 1
        else
          final_hash[state] = 1
        end
      end

      return final_hash
    end


 def self.listing_search_newused(listings)
      return {} if listings.size < 1

      final_hash = Hash.new

      listings.each do |listing|
        state = listing.newused
        if final_hash.has_key?(state)
          final_hash[state] += 1
        else
          final_hash[state] = 1
        end
      end

      return final_hash
    end


 def self.listing_search_transmission(listings)
      return {} if listings.size < 1

      final_hash = Hash.new

      listings.each do |listing|
        state = listing.transmission
        if final_hash.has_key?(state)
          final_hash[state] += 1
        else
          final_hash[state] = 1
        end
      end

      return final_hash
    end


 def self.listing_search_cylinder(listings)
      return {} if listings.size < 1

      final_hash = Hash.new

      listings.each do |listing|
        state = listing.cylinder
        if final_hash.has_key?(state)
          final_hash[state] += 1
        else
          final_hash[state] = 1
        end
      end

      return final_hash
    end


 def self.listing_search_fuel(listings)
      return {} if listings.size < 1

      final_hash = Hash.new

      listings.each do |listing|
        state = listing.fuel
        if final_hash.has_key?(state)
          final_hash[state] += 1
        else
          final_hash[state] = 1
        end
      end

      return final_hash
    end


 def self.listing_search_drive(listings)
      return {} if listings.size < 1

      final_hash = Hash.new

      listings.each do |listing|
        state = listing.drive
        if final_hash.has_key?(state)
          final_hash[state] += 1
        else
          final_hash[state] = 1
        end
      end

      return final_hash
    end


 def self.listing_search_trim(listings)
      return {} if listings.size < 1

      final_hash = Hash.new

      listings.each do |listing|
        state = listing.trim
        if final_hash.has_key?(state)
          final_hash[state] += 1
        else
          final_hash[state] = 1
        end
      end

      return final_hash
    end


 def self.listing_search_color(listings)
      return {} if listings.size < 1

      final_hash = Hash.new

      listings.each do |listing|
        state = listing.color
        if final_hash.has_key?(state)
          final_hash[state] += 1
        else
          final_hash[state] = 1
        end
      end

      return final_hash
    end


 def self.listing_search_year(listings)
      return {} if listings.size < 1

      final_hash = Hash.new

      listings.each do |listing|
        state = listing.year
        if final_hash.has_key?(state)
          final_hash[state] += 1
        else
          final_hash[state] = 1
        end
      end

      return final_hash
    end


 def self.listing_search_interiorcolor(listings)
      return {} if listings.size < 1

      final_hash = Hash.new

      listings.each do |listing|
        state = listing.interiorcolor
        if final_hash.has_key?(state)
          final_hash[state] += 1
        else
          final_hash[state] = 1
        end
      end

      return final_hash
    end



















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
	  		"StockNumber" => :stocknumber,
	      "BodyType" => :bodytype,
	      "Make" => :make,
	  		"Model"	=> :model,
	  		"year"	=> :year,
	  		"Trim"	=> :trim,
	  		"miles"	=> :miles,
	  		"EnginerDescription" => :enginedescription,
	  		"cylinder"	=> :cylinder,
	  		"fuel"	=> :fuel,
	  		"transmission" => :transmission,	
	  		"price" => :price,
	  		"color"	 => :color,
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

						# [:image, :imagefront, :imageback, :imageleft, :imageright, :frontinterior, :rearinterior].each do |image|				
						# 		#unless listing_images.size < 1
						# 			listing[image] = CsvUploading::picture_from_url(listing_images[i])
						# 			i += 1
						# 		#end
						# 	# p "hello"
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
			#Listing.import valid_listings, on_duplicate_key_update: { conflict_target: [:vin], columns: [:user_id, :newused, :stocknumber, :model, :year, :trim, :miles, :enginedescription,:cylinder,:fuel,:transmission,  :price, :color, :interiorcolor, :options, :description,:city, :state, :zipcode, :approved]}
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

	 def city_state
	    [state, zipcode].join(', ')
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
			

			if params[:category].present?
				if params[:category] != "All"
					listings = listings.where('LOWER(listings.make) like ?', "%#{params[:category].downcase}%") 
				end
			end

			if params[:subcategory].present?
				if params[:subcategory] != "All"
					listings = listings.where('LOWER(listings.model) like ?',"%#{params[:subcategory].downcase}%")
				end
			end

			
			listings = listings.where("listings.newused = '#{params[:NewUsed][0].upcase}'") if params[:NewUsed].present?
			listings = listings.where("price >= ?", "#{params[:minprice]}") if params[:minprice].present?			
			listings = listings.where("price <= ?", "#{params[:maxprice]}") if params[:maxprice].present?			


			listing2 = listings


			if params[:radius].present?
				#sleep 0.2
				if params[:location].present?
					ids = listings.near(params[:location].upcase,params[:radius], order: 'distance').map{|i| i.id} 
					listings = Listing.where(id: ids).order("position(id::text in '#{ids.join(',')}')")
					ids.clear
				end							
			else
				#sleep 0.2				
				if params[:location].present?
					ids = listings.near(params[:location].upcase,20, order: 'distance').map{|i| i.id} 
					listings = Listing.where(id: ids).order("position(id::text in '#{ids.join(',')}')")
					ids.clear
				end	
				
				#listings = Listing.where(id: listings.near(params[:location].upcase,20, order: 'distance').map{|i| i.id}) if params[:location].present?				
			end



			if listings.empty?
				#sleep 0.2		
				if params[:location].present?		
					ids = listing2.near(params[:location].upcase,100, order: 'distance').map{|i| i.id}
					listings = Listing.where(id: ids).order("position(id::text in '#{ids.join(',')}')")	
					ids.clear
				end 
						
			end




			# listings = listings.where('LOWER(listings.bodytype) like ?', "%#{params[:bodytype].downcase}%") if params[:bodytype].present?
					
			
			# Listing.where(id: repairshop.near(params[:location], params[:radius]).map{|i| i.id})			

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
			listings = Listing.where(approved: true).where('expiration_date > ?', DateTime.now)	

			if params[:bodytype].present?
				if params[:bodytype] != "All"
					listings = listings.where('LOWER(bodytype) like ?' ,"%#{params[:bodytype].downcase}%") if params[:bodytype].present?			
				end
			end
			
			listings = listings.where("listings.newused = '#{params[:NewUsed][0].upcase}'") if params[:NewUsed].present?
			listings = listings.where("price >= ?", "#{params[:minprice]}") if params[:minprice].present?			
			listings = listings.where("price <= ?", "#{params[:maxprice]}") if params[:maxprice].present?			


			listing2 = listings


			if params[:radius].present?
				#sleep 0.2
				if params[:location].present?
					ids = listings.near(params[:location].upcase,params[:radius], order: 'distance').map{|i| i.id} 
					listings = Listing.where(id: ids).order("position(id::text in '#{ids.join(',')}')")
					ids.clear
				end							
			else
				#sleep 0.2				
				if params[:location].present?
					ids = listings.near(params[:location].upcase,20, order: 'distance').map{|i| i.id} 
					listings = Listing.where(id: ids).order("position(id::text in '#{ids.join(',')}')")
					ids.clear
				end	
				
				#listings = Listing.where(id: listings.near(params[:location].upcase,20, order: 'distance').map{|i| i.id}) if params[:location].present?				
			end


			if listings.empty?
				#sleep 0.2		
				if params[:location].present?		
					ids = listing2.near(params[:location].upcase,100, order: 'distance').map{|i| i.id}
					listings = Listing.where(id: ids).order("position(id::text in '#{ids.join(',')}')")	
					ids.clear
				end 
						
			end
										

			listings

		else
			all
		end

	end

	
	def self.import_all_users(file) 
	    start = Time.now  
	    count = 0
	    valid_users = Array.new
	    data = {}   
	    user_emails = User.all.pluck(:email)
	    # last_user_id = User.last.id   
	    # users = User.all.as_json
	    # user_hash = Hash.new

	    # users.each do |i|
	    #   user_hash[i["id"]] = i
	    # end

	    map = {

	        "DLR_TYPE" => :type,      
	        "BUSINESS NAME" => :name,
	        "STREET ADDRESS"  => :street_address,
	        "DBA(S)" => :dba,
	        "CITY"   => :city,
	        "ST" => :state,
	        "ZIP" => :zipcode,
	        "PHONE #" => :phone_number

	      }

	    # p user_hash
	    # p "*******************************"
	    # p "*******************************"


	    # p Listing.count
	    # p Listing.delete_all
	    # p "problem is here 1"
	    CSV.foreach(file, headers: true, encoding:'iso-8859-1:utf-8') do |row|
	      #Use create when you dont need customization with the listing 
	      
	        row.to_hash.each do |k, v|
	          key = map[k]
	          data[key] = v
	        end

	        user = User.new

	        if  data[:type] == "AR" 
	          user.role = 2       
	        else
	          user.role = 1
	        end 

	        if data[:dba] and data[:dba] != ""
	          user.name = data[:dba]
	        else
	          user.name = data[:name] if data[:name]
	        end

	        #user.name = data[:name]  if data[:name]
	        user.city = data[:city] if data[:city]
	        user.zipcode = data[:zipcode] if data[:zipcode] 
	        user.state = data[:state] if data[:state] 
	        user.phone_number = data[:phone_number] if data[:phone_number]  
	        user.street_address = data[:street_address] if data[:street_address]


	        
	        # the_email = Listing.email_generator

	        # while !(user_emails.include?(the_email))
	        #   the_email = Listing.email_generator   
	        #   p "llop"     
	        # end

	        # user.email = the_email
	        # user_emails << the_email


	        user.email = "#{user.name.gsub(" ","")}@gmail.com"

	        p user.email

	        user.password = "123abc"
	        user.password_confirmation = "123abc"

	        if User.find_by_email(user.email) == nil 
	        	user.save!
	        end
	        
	        #begin

	        p "llop2"  
	  
	        valid_users << user       
	          
	        data.clear

	        # rescue Exception => e
	          
	        # end
	        
	    end

	    # p "problem is here 2"p valid_listings
	    # 

	      count = valid_users.size

	    # begin
	      # p valid_listings
	      #Listing.import valid_listings, on_duplicate_key_update: { conflict_target: [:vin], columns: [:user_id, :newused, :stocknumber, :model, :year, :trim, :miles, :enginedescription,:cylinder,:fuel,:transmission,  :price, :color, :interiorcolor, :options, :description,:city, :state, :zipcode, :approved]}
	      p "llop3"  
	      #User.import valid_users, on_duplicate_key_update: [:email, :password, :password_confirmation, :name, :role, :city, :zipcode, :state]
	      # }
	      # p Listing.count
	      # p Listing.all
	    # rescue
	    #   p "some issue"
	    # end

	    finish = Time.now
	    puts diff = finish - start
	    #count == 0 ? false : count    
	    # p self.last
	end

	def self.email_generator  
	  sample = (2..99).to_a
	  return "newuser#{sample.sample}#{sample.sample}#{sample.sample}@#{sample.sample}gmail.com"
	end




	def self.create_repair_shops
		#all_repairshops = User.where(:role => 2).pluck(:id).uniq
		#repairshops_users = Repairshop.pluck(:user_id).uniq
		#to_create_for = all_repairshops - repairshops_users
		to_create_for =  [58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129,130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161,162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193,194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222]

		to_create_for.each do |i|
			repairshop = Repairshop.new
			repairshop.user_id = i 
			user = User.find_by_id(i)
			repairshop.title = user.name
			repairshop.city = user.city
			repairshop.state = user.state
			repairshop.zipcode = user.zipcode
			repairshop.latitude = user.latitude
			repairshop.longitude = user.longitude
			repairshop.approved = true
			repairshop.description = "Not Added Yet! If you are the owner, contact us to claim"

			#begin
				#if Repairshop.find_by_title(repairshop.title) == nil
					repairshop.save!
				#end
			# rescue

			# end

		end

		return

	end

	# def self.update_or_create(attributes)
	#   assign_or_new(attributes).save
	# end

	# def self.assign_or_new(attributes)
	#   obj = first || new
	#   obj.assign_attributes(attributes)
	#   obj
	# end


	def self.export_oodle(type)
		oddle_attributes = %w{category description	id	title	url	address	city	country	neighborhood	state	zip_code	body_type	color	condition	create_time	currency	dealer_phone	expire_time	features	fee	image_url	interior_color	ip_address	make	mileage	mileage_units	model	price	registration	seller_email	seller_name	seller_phone	seller_type	seller_url	transmission	trim	vin	year}
		

		CSV.generate(headers: true) do |csv|
			if type == "oodle"
				csv << oddle_attributes
			end

			all.each do |listing|
				csv  << ["cars", listing.description, listing.id, listing.title, "https://wantacarbuyacar.com/listings/#{listing.id}", "#{listing.full_address}", listing.city, "USA", listing.city, listing.state, listing.zipcode, listing.bodytype, listing.color, listing.newused, listing.created_at, "USD", "", "", listing.options, "", listing.external_imagefront, listing.interiorcolor, "", listing.make, listing.miles, "miles", listing.model, listing.price, "", "wantacarbuyacar@gmail.com", "wantacarbuyacar.com", "(866)-338-7870", "dealer", "wantacarbuyacar.com", listing.transmission, listing.trim, listing.vin, listing.year]
			end
		end

	end 




	

end



