require 'csv_uploading' 
require 'csv'


class Listing < ActiveRecord::Base
	#attr_accessor :user
	include CsvUploading


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

	

	def self.import(file)		
		count = 0
		CSV.foreach(file.path, headers: true, encoding:'iso-8859-1:utf-8') do |row|
			#Use create when you dont need customization with the listing	

			data = {}

			row.to_hash.each do |k, v|
				key = MAP[k]
				data[key] = v
			end

			unless data[:vin] == nil


				listing =  Listing.find_by_vin(data[:vin]) || Listing.new

				#listing.attributes = (row.to_hash).merge(image: URI.parse(row['image'])) #			
				listing.title = "#{data[:year]} #{data[:make]} #{data[:model]}"
				user = User.find_by_id(data[:user_id])

				p "*******************************"
				p "*******************************"

				p user
				if user != nil
					listing.city = user.city 
					listing.state = user.state 
					listing.zipcode = user.zipcode 
				end

				listing.approved = true

				# p data[:all_images]
				p "*******************************"
				p "*******************************"

				

				unless data[:all_images] == nil



					listing_images = data[:all_images].split(",")
					i = 0
				
					[:image, :imagefront, :imageback, :imageleft, :imageright, :frontinterior, :rearinterior].each do |image|				
						unless listing_images.size < 1
							data[image] = CsvUploading::picture_from_url(listing_images[i])
							i += 1
						end
						p "hello"
					end

				end

				#listing.attributes = (row.to_hash).merge(user_id: current_user.id) #
				data.delete(:all_images)

				# listing.attributes = .merge(user_id: current_user.id).merge(category_id: row["category"]).merge(subcategory_id: row["subcategory"])
				p data
				listing.attributes = data

				# return false unless listing.valid?

				if listing.valid?
					#Listing.create!((row.to_hash).merge(user_id: current_user.id))
					if listing.save!
						count = count+1
						p listing
					end									
				end

				

				p "*******************************"
				p "*******************************"

				

				#listing = Listing.where(:vin => row["Vin"]).first_or_create(row.to_hash).merge(user_id: current_user.id)
			 	#Otherwise use new as shown below

			 	# listing = find_by_id(row["vin"]) || new			 	
			 	# listing.attributes = row.to_hash.slice()
			 	# listing.user = current_user
			 	# listing.save		 
			 end
		end
		count == 0 ? false : count		
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



