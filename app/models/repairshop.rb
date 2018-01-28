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

	scope :silver_repairshops, -> {joins(:user).where('users.role = ?', 5)}
	scope :diamond_repairshops, -> {joins(:user).where('users.role = ?', 6)}
	scope :basic_repairshops, ->{joins(:user).where('users.role = ?', 2)}
	
	scope :repairshop_search_cities, -> {group(:city).count}
	scope :repairshop_search_states, -> {group(:state).count}
	

	# scope :premium_repairshop 

	def self.search(params)
		if params
			repairshop = Repairshop.where(:approved => true)
			
			if params[:radius].present?
				repairshop = Repairshop.where(id: repairshop.near(params[:location], params[:radius]).map{|i| i.id}) if params[:location].present?
			else
				repairshop = Repairshop.where(id: repairshop.near(params[:location], 200).map{|i| i.id}) if params[:location].present?				
			end

			if params[:keywords].present?
				repairshop = repairshop.joins(:specializations).joins(:brands_we_services).where("LOWER(specializations.title) LIKE ? OR LOWER(brands_we_services.title) LIKE ? OR LOWER(repairshops.title) LIKE ?", "%#{params[:keywords].downcase}%", "%#{params[:keywords].downcase}%", "%#{params[:keywords].downcase}%")
			end

			repairshop.uniq
		else
			all
		end

	end

	
end

