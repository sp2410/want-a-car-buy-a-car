class Repairshop < ActiveRecord::Base
	belongs_to :user
	has_many :coupons, :dependent => :destroy
	has_many :specializations, :dependent => :destroy
	has_many :brands_we_services, :dependent => :destroy
	validates_presence_of :title
	# validates_presence_of :zipcode


	mount_uploader :image, ImageUploader
	
	geocoded_by :full_address
	after_validation :geocode

	def full_address
		[city, state, zipcode].join(', ')
	end

	def self.search(params)
		if params
			repairshop = Repairshop.all
			
			if params[:radius].present?
				repairshop = repairshop.near(params[:location], params[:radius]) if params[:location].present?
			else
				repairshop = repairshop.near(params[:location], 200) if params[:location].present?				
			end

			if params[:keywords].present?
				repairshop = repairshop.joins(:specializations).joins(:brands_we_services).where("LOWER(specializations.title) LIKE ? OR LOWER(brands_we_services.title) LIKE ? OR LOWER(repairshop.title) LIKE ?", "%#{params[:keywords].downcase}%", "%#{params[:keywords].downcase}%", "%#{params[:keywords].downcase}%")
			end

			repairshop.uniq
		else
			all
		end

	end

	

end

