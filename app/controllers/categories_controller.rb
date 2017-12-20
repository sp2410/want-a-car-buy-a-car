class CategoriesController < ApplicationController

	#skip_before_action :authenticate_user!, :only => [:index]

	#caches_page :index
	#:skip_before_filter :require_no_authentication, only: [:index]
	
	def index		
		@hide_menu = true		
		@categories = Category.all

		# respond_to do |format|
		# 	format.html
		# 	format.json {render json: @categories }
		# end


		#authorize @categories
		#@categories.index
		@suv = @categories[0]
		@sedan = @categories[1]
		@truck = @categories[2]		
		@van = @categories[3]
		@coupe = @categories[4]	
		@wagon = @categories[5]	
		@convertible = @categories[6]	
		@sports = @categories[7]	
		@diesel = @categories[8]	
		@crossover = @categories[9]	
		@luxury = @categories[10]
		@hatchback = @categories[11]	
		@other = @categories[12]	
			
		@alllistings = Listing.joins(:user).select('users.email, listings.*')
		@listings = Listing.where(:wholesale => false)
		#@listings = Listing.order(params[:sort])	

		@repairshops = Repairshop.all	
		
		@wholesalelistings = Listing.where(:wholesale => true)

		@premiumlistings = Listing.where(:wholesale => false).joins(:user).where("users.role = '2'")

		@newcars = Listing.where(:newused => "N")
		@usedcars = Listing.where(:newused => "U")
		@wholesalecars = Listing.all.limit(5)
		

		respond_to do |format|
			format.html
			format.csv {send_data @listings.to_csv }			
			format.xml { render :xml => @alllistings}					
			format.json { render :json => @alllistings}					

		end
	

	end

	def show		
		@listings = Listing.where(category_id: params[:id]).order(sort_column + " " + sort_direction)	
			
		@category = Category.find(params[:id])
	 # if current_user.role != "premium" and @category == "suv"
	 #	flash[:notice] = "Please don't try it again"
	 #   		redirect_to root
	 #   	end
	end

	private 

	def sort_column
		params[:sort] ||= "created_at"
	end

	def sort_direction
		params[:direction] ||= "asc"
	end
end