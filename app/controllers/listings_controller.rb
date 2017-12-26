class ListingsController < ApplicationController

	before_action :authenticate_user!, only: [:new, :create, :mylistings]
	before_action :user_allowed_to_create_listings, only: [:new, :create, :edit, :update, :destory]
	before_filter :is_user?, only: [:edit, :update, :delete]

	before_action :get_number_of_cars, only: [:search,:bodysearch,:index ]
	before_action :get_number_of_repairshops, only: [:search,:bodysearch,:index]


	def index
	end
	
	def new
		@listing = Listing.new
	end	

	def create
		@listing = Listing.new(listing_params)
		@listing.user = current_user

		@listing.city = current_user.city		
		@listing.state = current_user.state
		@listing.zipcode = current_user.zipcode
		@listing.title = "#{@listing.year} #{@listing.make} #{@listing.model}"
		

		if @listing.save				
			redirect_to @listing			
		else
			flash[:alert] =  @listing.errors.full_messages.to_sentence
			render 'new'
		end
	end

	def show
		@listing = Listing.find(params[:id])
		@parent = @listing
		@user = User.find_by_id(@listing.user_id)
		@listings = Listing.where(user: @listing.user)
		@reviews = Review.where('owner_id = ?', @user.id)
		
	end

	def edit
		@listing = Listing.find(params[:id])
	end

	def update
		@listing = Listing.find(params[:id])
		@listing.update(listing_params)
		
		if @listing.update(listing_params)
			redirect_to @listing
		else 
			flash[:alert] =  "Sorry Couldn't Update right now"
		end
	end

	def search		
		# @listings = Listing.search(params).order("#{sort_column}" + " " + "#{sort_direction}")
		@listings = Listing.search(params)		

	end

	def bodysearch		
		# @listings = Listing.bodysearch(params).order("#{sort_column}" + " " + "#{sort_direction}")
		@listings = Listing.all
	end

	# def searchbyuser		
	# 	@listings = Listing.searchbyuser(params)
	# 	respond_to do |format|	      	
	#       	format.json { render :json => @mylistings.to_json }
 #    	end
	# end

	def destroy
		@listing = Listing.find(params[:id])
		@listing.destroy
		redirect_to root_path
		flash[:alert] =  "Listing Deleted"
	end

	# def import

	# 	@imported = Listing.import(params[:file], current_user)	
		

	# 	if @imported
	# 	    redirect_to root_url, notice: "#{@imported} Listings imported successfully"
	#   	else 
	#     	flash[:alert] =  "All Listings Not Imported! There were either some errors, or the VIN was duplicate"
	#     	redirect_to root_url
	#   	end 


	# 	# clearancing_status = ClearancingService.new.process_file(params[:csv_batch_file].tempfile)
	#     # clearance_batch    = clearancing_status.clearance_batch
	#     # alert_messages     = []
	#     # if clearance_batch.persisted?
	#     #   flash[:notice]  = "#{clearance_batch.items.count} items clearanced in batch #{clearance_batch.id}"
	#     # else
	#     #   alert_messages << "No new clearance batch was added"
	#     # end
	#     # if clearancing_status.errors.any?
	#     #   alert_messages << "#{clearancing_status.errors.count} item ids raised errors and were not clearanced"
	#     #   clearancing_status.errors.each {|error| alert_messages << error }
	#     # end
	#     # flash[:alert] = alert_messages.join("<br/>") if alert_messages.any?

	# end

	def mylistings

		if current_user		
			@user_listings = Listing.where('user_id=?', current_user.id)	
			@newcars = @user_listings.where('user_id=?', current_user.id)	
			@usedcars = @user_listings.where('user_id=?', current_user.id)	
			@wholesalecars = @user_listings.limit(5)

		else
				redirect_to new_user_session
		end

	end

	def usedcars
		@usedcars = Listing.where('newused=?', "U")	
	end

	def newcars
		@newcars = Listing.where('newused=?', "N")	
	end

	

	private


	def listing_params
		params.require(:listing).permit(:description, :city, :state, :zipcode, :category_id, :subcategory_id, :image, :year, :miles, :transmission, :color, :cylinder, :fuel, :drive, :address,:wholesale,:price, :newused, :vin , :stocknumber, :model, :trim, :enginedescription,:interiorcolor,:options, :imagefront, :imageback, :imageleft, :imageright, :frontinterior, :rearinterior, :make)
		

	end

	def get_number_of_cars
		@carcount = Listing.all.count
	end

	def get_number_of_repairshops
		@repairshopscount = Repairshop.all.count
	end


	def is_user?
		@listing = Listing.find(params[:id])
		unless @listing.user == current_user 
			redirect_to root_path, alert: "Sorry, You are not the owner"
		end
	end

	def user_allowed_to_create_listings
		if !current_user.nil?
			unless current_user.user_can_create_listing
				redirect_to root_path, alert: "Sorry, You are not allowed for this action. Please change the user package or contat us."
			end
		end
	end

	def sort_column
		params[:sort] ||= "created_at"
	end

	def sort_direction
		params[:direction] ||= "asc"
	end

	def myparams
		params
	end

	def apply_filters(relation)
		case params[:filter]
		when "year"
			relation.with_year
		else
			relation
		end
	end

	
end