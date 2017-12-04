class Category < ActiveRecord::Base
	has_many :subcategories, :dependent => :delete_all
	has_many :listings, :dependent => :delete_all
	#has_many :repairshops
	
end