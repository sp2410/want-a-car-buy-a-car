class CouponsController < ApplicationController

	before_action :authenticate_user!, only: [:new, :create, :destroy, :update]
	before_action :is_user?, only: [:new, :create, :destroy, :update]

	before_action :user_allowed_to_create_coupons, only: [:new, :create, :edit, :update, :destory]

	before_action :set_parents, only:  [:new, :create] 
	before_action :set_child_and_parents, only:  [:destroy, :update, :update, :edit]


	def index
		@coupons = Coupon.all.order('created_at DESC')
	end 

	def new
		@coupon = Coupon.new
	end

	def edit
				
	end

	def create
		@coupon = Coupon.new(coupon_params)	
		@coupon.repairshop_id = @repairshop.id

		respond_to do |format|
			if @coupon.save	
				format.html { redirect_to @repairshop, notice: 'Coupon was successfully created.' }
		        format.json { render :show, status: :created, location:@repairshop }
			else				
				format.html { render :new }
		        format.json { render json: @coupon.errors, status: :unprocessable_entity }
			end
		end

	end

	def destroy
		@coupon.destroy
		respond_to do |format|						
		    format.html { redirect_to @repairshop, notice: 'Coupon  was successfully destroyed.' }
		    format.json { head :no_content }
		end

	end

	def update
		respond_to do |format|
	      	if @coupon.update(coupon_params)
		        format.html { redirect_to @repairshop, notice: 'Coupon was updated.' }
		        format.json { render :show, status: :ok, location: @repairshop}
	      	else
		        format.html { render :edit }
		        format.json { render json: @Coupon.errors, status: :unprocessable_entity }
	    	end
    	end
	end

	private

	def coupon_params
      params.require(:coupon).permit(:image, :title)
    end

    def set_child_and_parents
    	@coupon = Coupon.find_by_id(params[:id])
    	@repairshop = Repairshop.find_by_id(params[:repairshop_id])
    end

    def set_parents    	
    	@repairshop = Repairshop.find_by_id(params[:repairshop_id])
    	p "hello #{@repairshop}"
    end

    def is_user?
		@repairshop = Repairshop.find(params[:repairshop_id])
		if @repairshop.user != current_user 
			redirect_to @repairshop, alert: "Sorry, You are not the author"
		end
	end

	def user_allowed_to_create_coupons
		if !current_user.nil?
			set_parents 
			unless current_user.user_can_create_repairshop		
				redirect_to @repairshop, alert: "Sorry, You are not allowed for this action. Please change the user package or contat us. If you are an automotive dealer, we will handle your bulk uploading."
			end
		end
	end

end

