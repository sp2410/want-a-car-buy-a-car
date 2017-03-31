class Category < ActiveRecord::Base
	has_many :subcategories
	has_many :listings
	#has_many :repairshops
	
end