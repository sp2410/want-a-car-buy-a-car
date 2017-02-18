class Listing < ActiveRecord::Base
	belongs_to :category
	belongs_to :subcategory
	belongs_to :user

	validates :user_id, presence: true
	
	validates_presence_of :title
	validates_presence_of :city
	validates_presence_of :state
	validates_presence_of :description
	
	
	
	mount_uploader :image, ImageUploader


	geocoded_by :full_address
	after_validation :geocode

	def self.to_csv
		CSV.generate do |csv|
			csv << column_names
			all.each do |l|
				csv << l.attributes.values_at(*column_names)
			end
		end
	end	

	def self.import(file)		
		CSV.foreach(file.path, headers: true) do |row|
		 	# listing = find_by_id(row["id"]) || new
		 	# listing.attributes = row.to_hash.slice()
		 	Listing.create! row.to_hash
		end

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

	# def self.sortbynewest
	# 	find(:all, :order => )
	# end

	# def self.sortbyoldest
	# end

	# def self.sortbyhightolowprice
	# end

	# def self.sortbylowtohighprice
	# end




	def self.search(params)
		listings = Listing.where(category_id: params[:category].to_i)
		listings = listings.where("title LIKE ? or description LIKE ?", "%#{params[:search]}%", "%#{params[:search]}%") if params[:search].present? 
		listings = listings.where("price <= ?", "#{params[:price]}") if params[:price].present?
		listings = listings.near(params[:location],100) if params[:location].present?

		listings


	end

end



