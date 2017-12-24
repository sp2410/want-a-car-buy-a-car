class RepairshopsController < InheritedResources::Base

	before_filter :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
	before_filter :is_user?, only: [:edit, :update, :delete]

	before_action :user_allowed_to_create_repairshops, only: [:new, :create, :edit, :update, :destory]
	
	before_action :get_number_of_cars, only: [:search,:bodysearch,:index ]
	before_action :get_number_of_repairshops, only: [:search,:bodysearch,:index]
	
	include ApplicationHelper

	def index
		@repairshops = Repairshop.all
	end	

	def new
		@repairshop = Repairshop.new
	end

	def create
		@repairshop = Repairshop.new(repairshop_params)
		@repairshop.user = current_user

		@repairshop.city = current_user.city		
		@repairshop.state = current_user.state
		@repairshop.zipcode = current_user.zipcode
		@repairshop.phone = current_user.phone_number

		if @repairshop.save			
			redirect_to @repairshop
		else
			flash[:alert] =  @repairshop.errors.full_messages.to_sentence
			render 'new'
		end
	end

	def show
		@repairshop = Repairshop.find(params[:id])
		@parent = @repairshop	
		@desc = @repairshop.description.split(',')	
		@coupons = @repairshop.coupons if @repairshop != nil
		@specialization = @repairshop.specializations  if @repairshop != nil
		@brands_we_service = @repairshop.brands_we_services if @repairshop != nil
		@user = User.find_by_id(@repairshop.user_id)
		@reviews = Review.where('owner_id = ?', @repairshop.user_id)		
	end

	def update
		@repairshop = Repairshop.find(params[:id])		
		@repairshop.update(repairshop_params)
		
		if @repairshop.update(repairshop_params)
			redirect_to @repairshop
		else 
			flash[:alert] =  "Sorry couldn't update right now"
		end
	end

	def destory
		@repairshop = Repairshop.find(params[:id])
		@repairshop.destroy
		redirect_to root_path
		flash[:alert] =  "Your Shop Has Been Deleted"
	end

	def edit
		@repairshop = Repairshop.find(params[:id])
	end

	def search
		@repairshops = Repairshop.search(params)
	end

	def myrepairshops
		if current_user		
			@repairshops = Repairshop.where('user_id=?', current_user.id)				
		else
			redirect_to new_user_session
		end

	end


  private

  	def user_allowed_to_create_repairshops
  		if !current_user.nil?
			unless current_user.user_can_create_repairshop
				redirect_to root_path, alert: "Sorry, You can't create a repairshop. Please change the user package or contact us"
			end
		end
	end

	def is_user?
		@repairshop = Repairshop.find(params[:id])
		unless @repairshop.user == current_user 
			redirect_to root_path, alert: "Sorry, You are not the owner"
		end
	end

  	def get_number_of_cars
		@carcount = Listing.all.count
	end

	def get_number_of_repairshops
		@repairshopscount = Repairshop.all.count
	end


    def repairshop_params
      params.require(:repairshop).permit(:title, :description, :city, :state, :zipcode, :phone, :image, :shop_type)
    end
end

