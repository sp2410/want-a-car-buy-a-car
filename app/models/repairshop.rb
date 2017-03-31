class Repairshop < ActiveRecord::Base
	belongs_to :user
	has_many :categories
	validates_presence_of :title
	validates_presence_of :zipcode


	mount_uploader :image, ImageUploader

	geocoded_by :full_address
	after_validation :geocode

	def full_address
		[city, state, zipcode].join(', ')
	end

	def self.search(params)
		if params
			repairshop = Repairshop.all
			#repairshop = repairshop.where("description like '#{params[:specialisation]}'") if params[:specialisation].present?
			#listings = listings.where("carcompany  like '#{params[:NewUsed][0].upcase}'") if params[:NewUsed].present?			
			if params[:radius].present?
				repairshop = repairshop.near(params[:location], params[:radius]) if params[:location].present?
			else
				repairshop = repairshop.near(params[:location], 200) if params[:location].present?				
			end


			repairshop
		else
			all
		end

	end

end
