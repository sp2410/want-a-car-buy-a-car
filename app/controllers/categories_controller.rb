class CategoriesController < ApplicationController

	#skip_before_action :authenticate_user!, :only => [:index]

	#caches_page :index
	#:skip_before_filter :require_no_authentication, only: [:index]
	
	def index		

		@repairshops = Repairshop.where(:approved => true)

		@alllistings = Listing.all	
						
		@newcars = Listing.approved_new
		@usedcars = Listing.approved_used
		@wholesalecars = Listing.approved_wholesale
		

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