class Listing < ActiveRecord::Base
	#attr_accessor :user

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


		
	mount_uploader :image, ImageUploader
	
	mount_uploader :imagefront, ImageUploader
	mount_uploader :imageback, ImageUploader
	mount_uploader :imageleft, ImageUploader
	mount_uploader :imageright, ImageUploader
	mount_uploader :frontinterior, ImageUploader
	mount_uploader :rearinterior, ImageUploader

	


	geocoded_by :full_address
	after_validation :geocode

	filterrific(
		default_filter_params: { sorted_by: 'created_at_desc' },
		available_filters: [
	    :sorted_by,
	    :search_query,
	    :with_category_id,
	    :with_subcategory_id,
	    :with_created_at_gte
	  ]
	)


	# def save_with_a_user
	#  set_user!(listing_user)
	#  user_id = listing_user.id
	#  save!
	# end

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |l|
				csv << l.attributes.values_at(*column_names)
			end
		end
	end	

	def self.import(file, current_user)		
		count = 0
		CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
			#Use create when you dont need customization with the listing			
			listing =  Listing.new

			#listing.attributes = (row.to_hash).merge(image: URI.parse(row['image'])) #
			#listing.attributes = (row.to_hash.except("image")).merge(user_id: current_user.id) #
			#listing.attributes = (row.to_hash).merge(user_id: current_user.id) #

			listing.attributes = (row.to_hash.except("category").except("subcategory")).merge(user_id: current_user.id).merge(category_id: row["category"]).merge(subcategory_id: row["subcategory"])
			
			return false unless listing.valid?

			if listing.valid?
				#Listing.create!((row.to_hash).merge(user_id: current_user.id))
				listing.save!
				count = count+1									
			end
			

			#listing = Listing.where(:vin => row["Vin"]).first_or_create(row.to_hash).merge(user_id: current_user.id)
		 	#Otherwise use new as shown below

		 	# listing = find_by_id(row["vin"]) || new			 	
		 	# listing.attributes = row.to_hash.slice()
		 	# listing.user = current_user
		 	# listing.save		 
		end
		
		return count
	end

	def self.incrementcount(count)
		count = count+1
		return count
	end

	def returnthecount(count)
		return count
	end




	# def self.import(file)		
	# 	CSV.foreach(file.path, headers: true) do |row|
	# 	 	listing = find_by_id(row["vin"]) || new
	# 	 	#return false unless listing.valid?
	# 	 	#listing.user = current_user
	# 	 	listing.save		 	
	# 	end
	# end



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
			listings = Listing.all
			listings = listings.joins(:category).where("categories.name like '#{params[:category].downcase}'") if params[:category].present?
			listings = listings.where("listings.NewUsed = '#{params[:NewUsed][0].upcase}'") if params[:NewUsed].present?
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



