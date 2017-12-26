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

	
	scope :approved_wholesale, -> {joins(:user).where('users.role = ?', 6).where(approved: true).where(wholesale: true)}

	# scope :approved_wholesale, -> {where(approved: true).where(wholesale: true).where('users.role = ?', 6)}

	scope :approved_used, -> {joins(:user).where('users.role = ?', 6).where(approved: true).where(newused: "U")}

	scope :approved_new, -> {joins(:user).where('users.role = ?', 6).where(approved: true).where(newused: "N")}

	# scope

	

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
			listings = Listing.where(approved: true)
			listings = listings.where('LOWER(listings.make) like ?', "%#{params[:category].downcase}%") if params[:category].present?
			listings = listings.where('LOWER(listings.model) like ?',"%#{params[:subcategory].downcase}%") if params[:subcategory].present?
			listings = listings.where("listings.NewUsed = '#{params[:NewUsed][0].upcase}'") if params[:NewUsed].present?
			listings = listings.where("price >= ?", "#{params[:minprice]}") if params[:minprice].present?			
			listings = listings.where("price <= ?", "#{params[:maxprice]}") if params[:maxprice].present?			


			listings = listings.where('LOWER(listings.bodytype) like ?', "%#{params[:bodytype].downcase}%") if params[:bodytype].present?
					

			if params[:radius].present?
				listings = listings.near(params[:location],params[:radius]) if params[:location].present?
			else
				listings = listings.near(params[:location],200) if params[:location].present?
			end

			p "I am here"

			listings.uniq



		else

			p "I am here"
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



