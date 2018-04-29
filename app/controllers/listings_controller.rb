class ListingsController < ApplicationController

	before_action :authenticate_user!, only: [:new, :create, :mylistings]
	before_action :user_allowed_to_create_listings, only: [:new, :create, :edit, :update, :destory]
	before_action :is_user?, only: [:edit, :update, :delete]

	before_action :get_number_of_cars, only: [:search,:bodysearch,:index ]
	before_action :get_number_of_repairshops, only: [:search,:bodysearch,:index]
	


	def index
	end
	
	def new
		@listing = Listing.new
	end	

	def create
		listing_params[:external_url] = false
		
		@listing = Listing.new(listing_params)
		@listing.user = current_user

		@listing.city = current_user.city		
		@listing.state = current_user.state
		@listing.zipcode = current_user.zipcode
		@listing.latitude = current_user.latitude
		@listing.longitude = current_user.longitude
		@listing.title = "#{@listing.year} #{@listing.make} #{@listing.model}"
		
		if current_user.role == "BASIC USER"
			@listing.expiration_date = DateTime.now + 30.days
		end

		# @listing.external_url = false
		

		if verify_recaptcha(model: @listing) and @listing.save				
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
		# @listings = Listing.where(user: @listing.user)
		@reviews = Review.where('owner_id = ?', @user.id)

		@newcars = Listing.other_approved_new.where(user: @user).where.not(id: @listing.id)
		@usedcars = Listing.other_approved_used.where(user: @user).where.not(id: @listing.id)
		@wholesalecars = Listing.other_wholesale_listings.where(user: @user).where.not(id: @listing.id)

		# begin
		# 	if current_user	
		# 		NewLogCreator.perform_async({:contact => "#{current_user.email}, #{current_user.phone if current_user.phone}", :activity => "User opened #{@listing.id} owned by #{user.where(:id => @listing.user_id).email}", :type => "Page View"})							
		# 	else
		# 		NewLogCreator.perform_async({:contact => "Guest", :activity => "User opened #{@listing.id} owned by #{user.where(:id => @listing.user_id).email}", :type => "Page View"})							
		# 	end			
		# rescue

		# end
		
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

		@userLocation = request.location #gets the ip of the user
		#@searchResults = Geocoder.search(search_locations)
		#@locations = @searchResults.near(@userLocation, 5000000, :order => :distance)


		@sort_column = sort_column
		@sort_direction = sort_direction		
		@listings = Listing.search(params)#.order("#{@sort_column}" + " " + "#{@sort_direction}")
		# if @userLocation
		# 	@listings = Listing.search(params).near(@userLocation, 5000, order: 'distance')
		# else
		# 	@listings = Listing.search(params).order("#{@sort_column}" + " " + "#{@sort_direction}")
		# end
		

		# @radius = params[:radius] ? params[:radius] : 200

		# if params[:location]
		# 	@listings = @listings.near(params[:location].upcase, @radius, order: 'distance DESC')
		# end
		#.order("#{@sort_column}" + " " + "#{@sort_direction}")#.near(@userLocation, 5000000, :order => :distance)
		#@listings = Listing.search(params).near(@userLocation, 5000, :order => :distance)
		# @listings = Listing.search(params)	

		#Applied filters

		@current_filters = params[:filters] || {:filters => ""}	

		p params

		# @current_filters = @current_filters.merge({:sort => sort_column, :direction => sort_direction})

		if params[:filters]
	  		@listings = @listings.where(:cylinder => @current_filters[:cylinder]) if @current_filters[:cylinder]	  		
	  		@listings = @listings.where(:bodytype => @current_filters[:bodytype]) if @current_filters[:bodytype]
	  		@listings = @listings.where(:city => @current_filters[:city]) if @current_filters[:city]
	  		@listings = @listings.where(:state => @current_filters[:state]) if @current_filters[:state]
	  		@listings = @listings.where(:transmission => @current_filters[:transmission]) if @current_filters[:transmission]
	  		@listings = @listings.where(:newused => @current_filters[:newused]) if @current_filters[:newused]
	  		@listings = @listings.where(:fuel => @current_filters[:fuel]) if @current_filters[:fuel]
	  		@listings = @listings.where(:drive => @current_filters[:drive]) if @current_filters[:drive]
	  		@listings = @listings.where(:year => @current_filters[:year]) if @current_filters[:year]

	  		@listings = @listings.where(:interiorcolor => @current_filters[:interiorcolor]) if @current_filters[:interiorcolor]	  		
	  	end

	  	# @listings = @listings.order("#{sort_column}" + " " + "#{sort_direction}")

	  	@listings_cities = Listing.listing_search_cities(@listings)
		@listings_bodytype = Listing.listing_search_body_type(@listings)
		@listings_states = Listing.listing_search_states(@listings)

		@listings_newused = Listing.listing_search_newused(@listings)
		@listings_cylinder = Listing.listing_search_cylinder(@listings)
		@listings_transmission = Listing.listing_search_transmission(@listings)
		@listings_drive = Listing.listing_search_drive(@listings)
		@listings_trim = Listing.listing_search_trim(@listings)

		@listings_fuel = Listing.listing_search_fuel(@listings)

		@listings_color = Listing.listing_search_color(@listings)
		@listings_interiorcolor = Listing.listing_search_interiorcolor(@listings)
		@listings_year = Listing.listing_search_year(@listings)

		#@carcount = Listing.where(:approved => true).count
		#@repairshopscount = Repairshop.where(:approved => true).count
		#@dealercount = User.get_dealers_count

		# begin
		# 	if current_user	
		# 		NewLogCreator.perform_async({:contact => "#{current_user.email}, #{current_user.phone if current_user.phone}", :activity => "User searched for #{params} for a car", :type => "Search"})
		# 	else
		# 		NewLogCreator.perform_async({:contact => "Guest", :activity => "User searched for #{params} for a car", :type => "Search"})
		# 	end			
		# rescue

		# end
		


	end

	def bodysearch		
		
		# @listings = Listing.all

		@sort_column = sort_column
		@sort_direction = sort_direction		
		@listings = Listing.bodysearch(params)#.order("#{sort_column}" + " " + "#{sort_direction}")


		@current_filters = params[:filters] || {:filters => ""}		

		# @current_filters = @current_filters.merge({:sort => sort_column, :direction => sort_direction})

		if params[:filters]
	  		@listings = @listings.where(:cylinder => @current_filters[:cylinder]) if @current_filters[:cylinder]	  		
	  		@listings = @listings.where(:bodytype => @current_filters[:bodytype]) if @current_filters[:bodytype]
	  		@listings = @listings.where(:city => @current_filters[:city]) if @current_filters[:city]
	  		@listings = @listings.where(:state => @current_filters[:state]) if @current_filters[:state]
	  		@listings = @listings.where(:transmission => @current_filters[:transmission]) if @current_filters[:transmission]
	  		@listings = @listings.where(:newused => @current_filters[:newused]) if @current_filters[:newused]
	  		@listings = @listings.where(:fuel => @current_filters[:fuel]) if @current_filters[:fuel]
	  		@listings = @listings.where(:drive => @current_filters[:drive]) if @current_filters[:drive]
	  		@listings = @listings.where(:year => @current_filters[:year]) if @current_filters[:year]

	  		@listings = @listings.where(:interiorcolor => @current_filters[:interiorcolor]) if @current_filters[:interiorcolor]	  		
	  	end

	  	
		@listings_cities = Listing.listing_search_cities(@listings)
		@listings_bodytype = Listing.listing_search_body_type(@listings)
		@listings_states = Listing.listing_search_states(@listings)

		@listings_newused = Listing.listing_search_newused(@listings)
		@listings_cylinder = Listing.listing_search_cylinder(@listings)
		@listings_transmission = Listing.listing_search_transmission(@listings)
		@listings_drive = Listing.listing_search_drive(@listings)
		@listings_trim = Listing.listing_search_trim(@listings)

		@listings_fuel = Listing.listing_search_fuel(@listings)

		@listings_color = Listing.listing_search_color(@listings)
		@listings_interiorcolor = Listing.listing_search_interiorcolor(@listings)
		@listings_year =Listing.listing_search_year(@listings)

		#@carcount = Listing.where(:approved => true).count
		#@repairshopscount = Repairshop.where(:approved => true).count
		#@dealercount = User.get_dealers_count

		# begin
		# 	if current_user	
		# 		NewLogCreator.perform_async({:contact => "#{current_user.email}, #{current_user.phone if current_user.phone}", :activity => "User searched for #{params} for a car", :type => "Search"})
		# 	else
		# 		NewLogCreator.perform_async({:contact => "Guest", :activity => "User searched for #{params} for a car", :type => "Search"})
		# 	end			
		# rescue

		# end
		
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

	def import
		begin
			# CsvWorker.perform_async(params[:file].path)		
			CsvWorker.perform_async(params[:file])		
			redirect_to root_url, notice: "Hello! This upload job has been added for background importing. Please wait for few minutes and then cross check on listings page. Please recheck your CSV file headers and rows if new listings were not imported."
		rescue
			redirect_to root_url, notice: "There was some error with the import. Kindly check your CSV file or contact admin."
		end		
		# @imported = Listing.import_listings(params[:file])

		# if @imported == true
		#     redirect_to root_url, notice: "#{@imported} Listings imported successfully"
	 #  	elsif @imported == false
	 #    	flash[:alert] =  "All Listings Not Imported! There were either some errors, or the VIN was duplicate"
	 #    	redirect_to root_url	  	
	 #  	end


		# clearancing_status = ClearancingService.new.process_file(params[:csv_batch_file].tempfile)
	    # clearance_batch    = clearancing_status.clearance_batch
	    # alert_messages     = []
	    # if clearance_batch.persisted?
	    #   flash[:notice]  = "#{clearance_batch.items.count} items clearanced in batch #{clearance_batch.id}"
	    # else
	    #   alert_messages << "No new clearance batch was added"
	    # end
	    # if clearancing_status.errors.any?
	    #   alert_messages << "#{clearancing_status.errors.count} item ids raised errors and were not clearanced"
	    #   clearancing_status.errors.each {|error| alert_messages << error }
	    # end
	    # flash[:alert] = alert_messages.join("<br/>") if alert_messages.any?

	end

	def mylistings

		if current_user		
			@user_listings = Listing.where('user_id=?', current_user.id)	
			@newcars = @user_listings.where('user_id=?', current_user.id).where(:newused => "N").order("#{sort_column}" + " " + "#{sort_direction}")	
			@usedcars = @user_listings.where('user_id=?', current_user.id).where(:newused => "U").order("#{sort_column}" + " " + "#{sort_direction}")	
			@wholesalecars = @user_listings.where('user_id=?', current_user.id).where(:wholesale => true).order("#{sort_column}" + " " + "#{sort_direction}")

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

	def dealer_search		
		# @listings = Listing.search(params).order("#{sort_column}" + " " + "#{sort_direction}")
		@dealers = User.dealer_search(params)		

		#Applied filters

		@current_filters = params[:filters] || {:filters => ""}		

		# @current_filters = @current_filters.merge({:sort => sort_column, :direction => sort_direction})

		if params[:filters]
	  		
	  		@dealers = @dealers.where(:city => @current_filters[:city]) if @current_filters[:city]
	  		@dealers = @dealers.where(:state => @current_filters[:state]) if @current_filters[:state]

	  		# @dealers = @dealers.joins(:reviews).where(:ratings => @current_filters[:ratings]) if @current_filters[:ratings]
	  		@dealers = User.where(id: @dealers.select{|dealer| dealer.get_dealer_rating == @current_filters[:ratings]}.map{|user| user.id}) if @current_filters[:ratings]
	  		
	  	end

	  	# @listings = @listings.order("#{sort_column}" + " " + "#{sort_direction}")

	  	@dealers_cities = User.dealers_search_cities(@dealers)
		@dealers_states = User.dealers_search_states(@dealers)
		@dealers_ratings = User.get_ratings_for_each(@dealers)

		#@carcount = Listing.where(:approved => true).count
		#@repairshopscount = Repairshop.where(:approved => true).count
		#@dealercount = User.get_dealers_count

		# begin
		# 	if current_user	
		# 		NewLogCreator.perform_async({:contact => "#{current_user.email}, #{current_user.phone if current_user.phone}", :activity => "User searched for #{params} for a dealership", :activity_type => "Search"})
		# 	else
		# 		NewLogCreator.perform_async({:contact => "Guest", :activity => "User searched for #{params} for a dealership", :activity_type => "Search"})
		# 	end			
		# rescue

		# end
		

	end

	def userpage 			
		# @user = User.find_by_id(@user_id)
		@user = User.where(:slug => params[:id]).first
		@user_id = @user.id
		# (slug: params[:id])	
		@times = Timetable.where(:user_id => @user_id)	

		# p @user

		@parent = @user		

		if current_user_is_sales_team
			@inquiries = Inquiry.all.order('created_at DESC')
		else
			@inquiries = Inquiry.where(:to_email => @user.email).order('created_at DESC')	
		end
		
		
		@user_listings = Listing.where('user_id=?', @user_id).where(:approved => true)
		
		@note = Note.new

		@newcars = @user_listings.where('user_id=?', @user_id).where(:approved => true).where(:newused => "N").order("#{sort_column}" + " " + "#{sort_direction}")
		@usedcars = @user_listings.where('user_id=?', @user_id).where(:approved => true).where(:newused => "U").order("#{sort_column}" + " " + "#{sort_direction}")
		@wholesalecars = @user_listings.where('user_id=?', @user_id).where(:approved => true).where(:wholesale => true).order("#{sort_column}" + " " + "#{sort_direction}")
		@repairshops = Repairshop.where('user_id=?', @user_id).where(:approved => true)

		# begin
		# 	if current_user	
		# 		NewLogCreator.perform_async({:contact => "#{current_user.email}, #{current_user.phone if current_user.phone}", :activity => "User opened #{params[:id]} user's page", :type => "Page View"})							
		# 	else
		# 		NewLogCreator.perform_async({:contact => "Guest", :activity => "User opened #{params[:id]} user's page", :type => "Page View"})						
		# 	end			
		# rescue

		# end
	end 

	# def userpage 
	# 	@user_id = params[:id]		
	# 	# @user = User.find_by_id(@user_id)
	# 	@user = User.where(slug: params[:id]) 
	# 	# (slug: params[:id])

	# 	@parent = @user		


	# 	@inquiries = Inquiry.where(:to_email => @user.email).order('created_at DESC')
		
	# 	@user_listings = Listing.where('user_id=?', @user_id).where(:approved => true)
		
	# 	@note = Note.new

	# 	@newcars = @user_listings.where('user_id=?', @user_id).where(:approved => true).where(:newused => "N").order("#{sort_column}" + " " + "#{sort_direction}")
	# 	@usedcars = @user_listings.where('user_id=?', @user_id).where(:approved => true).where(:newused => "U").order("#{sort_column}" + " " + "#{sort_direction}")
	# 	@wholesalecars = @user_listings.where('user_id=?', @user_id).where(:approved => true).where(:wholesale => true).order("#{sort_column}" + " " + "#{sort_direction}")
	# 	@repairshops = Repairshop.where('user_id=?', @user_id).where(:approved => true)
	# end 


	
	private


	def listing_params
		params.require(:listing).permit(:description, :city, :state, :zipcode, :category_id, :subcategory_id, :image, :year, :miles, :transmission, :color, :cylinder, :fuel, :drive, :address,:wholesale,:price, :newused, :vin , :stocknumber, :model, :trim, :enginedescription,:interiorcolor,:options, :imagefront, :imageback, :imageleft, :imageright, :frontinterior, :rearinterior, :make, :expiration_date, :external_url)
		

	end

	def get_number_of_cars
		@carcount = Listing.where(:approved => true).count
	end

	def get_number_of_repairshops
		@repairshopscount = Repairshop.where(:approved => true).count
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
		params[:sort] ||= "price"
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