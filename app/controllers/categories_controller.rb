class CategoriesController < ApplicationController

	#skip_before_action :authenticate_user!, :only => [:index]

	#caches_page :index
	#:skip_before_filter :require_no_authentication, only: [:index]
	
	def index		

		@repairshops = Repairshop.where(:approved => true)

		@alllistings = Listing.all	
						
		@newcars = Listing.approved_new.order("#{sort_column}" + " " + "#{sort_direction}")
		@usedcars = Listing.approved_used.order("#{sort_column}" + " " + "#{sort_direction}")
		@wholesalecars = Listing.other_wholesale_listings.order("#{sort_column}" + " " + "#{sort_direction}")

		@listings = Listing.approved_all
		

		respond_to do |format|
			format.html			
			format.xml { render :xml => @alllistings}					
			format.json { render :json => @alllistings}					
		end
	

	end
	

	private 

	def sort_column
		params[:sort] ||= "created_at"
	end

	def sort_direction
		params[:direction] ||= "asc"
	end
end