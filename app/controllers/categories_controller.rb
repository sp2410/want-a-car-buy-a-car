class CategoriesController < ApplicationController

	#skip_before_action :authenticate_user!, :only => [:index]

	#caches_page :index
	#:skip_before_filter :require_no_authentication, only: [:index]

	include ApplicationHelper
	
	def index		

		@repairshops = Repairshop.where(:approved => true)

		@alllistings = Listing.all	
						
		@newcars = Listing.approved_new.order(sort_column + " " + sort_direction).where(:wholesale => false).sample(20)
		@usedcars = Listing.approved_used.order(sort_column + " " + sort_direction).where(:wholesale => false).sample(20)
		@wholesalecars = Listing.other_wholesale_listings.order(sort_column + " " + sort_direction).sample(20)

		@listings = Listing.approved_all

		@carcount = Listing.where(:approved => true).count
		@repairshopscount = Repairshop.where(:approved => true).count
		@dealercount = User.get_dealers_count
		
		

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

	# def sort_column           
 #      Listing.column_names.include?(params[:sort]) ? params[:sort] : "year"
 #    end      

 #    def sort_direction
 #      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
 #    end


end