class CategoriesController < ApplicationController

	#skip_before_action :authenticate_user!, :only => [:index]

	#caches_page :index
	#:skip_before_filter :require_no_authentication, only: [:index]
	
	def index		

		#@carcount = Listing.where(:approved => true).count
		#@repairshopscount = Repairshop.where(:approved => true).count
		#@dealercount = User.get_dealers_count
						
		@newcars = Listing.approved_new.order("#{sort_column}" + " " + "#{sort_direction}").where(:wholesale => false).sample(6)
		@all_used = Listing.approved_used.order("#{sort_column}" + " " + "#{sort_direction}").where(:wholesale => false)
		@usedcars = @all_used.sample(6)
		@wholesalecars = Listing.other_wholesale_listings.order("#{sort_column}" + " " + "#{sort_direction}").sample(6)
 
		#@carcount = Listing.approved_all.count
		
		respond_to do |format|
			format.html			
			#flash[:notice] =  "Welcome!"
			#format.xml { render :xml => @alllistings}					
			#format.json { render :json => @alllistings}					
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