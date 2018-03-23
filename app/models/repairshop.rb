class Repairshop < ActiveRecord::Base
	belongs_to :user
	has_many :coupons, :dependent => :delete_all 
	has_many :specializations, :dependent => :delete_all 
	has_many :brands_we_services, :dependent => :delete_all 
	validates_presence_of :title
	# validates_presence_of :zipcode


	def to_param
	    "#{id}-#{title}".parameterize
	 end

	mount_uploader :image, ImageUploader
	
	geocoded_by :full_address
	after_validation :geocode

	def full_address
		[city, state, zipcode].join(', ')
	end

	scope :silver_repairshops, -> {joins(:user).where('users.role = ?', 5)}
	scope :diamond_repairshops, -> {joins(:user).where('users.role = ?', 6)}
	scope :basic_repairshops, ->{joins(:user).where('users.role = ?', 2)}
	
	# scope :repairshop_search_cities, -> {group('created_at, city').count}
	# scope :repairshop_search_states, -> {group('created_at, state').count}


	def self.repairshop_search_cities(listings)
      return {} if listings.size < 1

      final_hash = Hash.new

      listings.each do |listing|
        state = listing.city
        if final_hash.has_key?(state)
          final_hash[state] += 1
        else
          final_hash[state] = 1
        end
      end

      return final_hash
    end


    def self.repairshop_search_states(listings)
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
	

	# scope :premium_repairshop 

	def self.search(params)
		if params
			repairshop = Repairshop.where(:approved => true)
			
			if params[:radius].present?
				sleep 0.2 
				repairshop = Repairshop.where(id: repairshop.near(params[:location], params[:radius]).map{|i| i.id}) if params[:location].present?
			else
				sleep 0.2 
				repairshop = Repairshop.where(id: repairshop.near(params[:location], 20).map{|i| i.id}) if params[:location].present?				
			end

			if repairshop.empty?
				sleep 0.2 
				repairshop = Repairshop.where(id: repairshop.near(params[:location], 100).map{|i| i.id}) if params[:location].present?				
			end

			if params[:keywords].present?
				repairshop = repairshop.joins("LEFT JOIN specializations ON specializations.repairshop_id = repairshops.id").joins("LEFT JOIN brands_we_services ON brands_we_services.repairshop_id = repairshops.id").where("LOWER(specializations.title) LIKE ? OR LOWER(brands_we_services.title) LIKE ? OR LOWER(repairshops.title) LIKE ?", "%#{params[:keywords].downcase}%", "%#{params[:keywords].downcase}%", "%#{params[:keywords].downcase}%")
			end

			# repairshop.uniq
			repairshop
		else
			all
		end




	end

	

	
end

