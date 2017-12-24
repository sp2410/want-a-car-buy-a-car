class BrandsWeServicesController < InheritedResources::Base

	before_action :authenticate_user!, only: [:new, :create, :destroy, :update]
	before_action :is_user?, only: [:new, :create, :destroy, :update]

	before_action :user_allowed_to_create_specalizations_and_brands, only: [:new, :create, :edit, :update, :destory]

	before_action :set_parents, only:  [:new, :create] 
	before_action :set_child_and_parents, only:  [:destroy, :update, :update, :edit]


	def new
		@brand_we_service = BrandsWeService.new
	end

	def edit
				
	end

	def create

		if params[:specializations]

			params[:specializations].each do |brands_we_service_params|
				@brands_we_service = BrandsWeService.new({:title => brands_we_service_params, :repairshop_id => @repairshop.id})					
				
				if !BrandsWeService.find_by_title(brands_we_service_params)
					begin
						@brands_we_service.save!
					rescue
						p "brands not saved"
					end
				end				
			end

			respond_to do |format|
				format.html {redirect_to @repairshop, notice: 'brands were successfully created.'}
			end

		else

			@brands_we_service = BrandsWeService.new(brands_we_service_params)	
			@brands_we_service.repairshop_id = @repairshop.id

			respond_to do |format|
				if @brands_we_service.save	
					format.html { redirect_to @repairshop, notice: 'brands was successfully created.' }
			        format.json { render :show, status: :created, location:@repairshop }
				else				
					format.html { render :new }
			        format.json { render json: @brands_we_service.errors, status: :unprocessable_entity }
				end
			end
		end

	end

	def destroy
		@brand_we_service.destroy
		respond_to do |format|						
		    format.html { redirect_to @repairshop, notice: 'brand was successfully destroyed.' }
		    format.json { head :no_content }
		end

	end

	def update
		respond_to do |format|
	      	if @brand_we_service.update(brands_we_service_params)
		        format.html { redirect_to @repairshop, notice: 'brand was updated.' }
		        format.json { render :show, status: :ok, location: @repairshop}
	      	else
		        format.html { render :edit }
		        format.json { render json: @brands_we_service_params.errors, status: :unprocessable_entity }
	    	end
    	end
	end

	private

	 def brands_we_service_params
      params.require(:brands_we_service).permit(:title)
    end

    def set_child_and_parents
    	@brand_we_service = BrandsWeService.find_by_id(params[:id])
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

	def user_allowed_to_create_specalizations_and_brands
		if !current_user.nil?
			set_parents 
			unless current_user.user_can_create_specalizations_and_brands
				redirect_to @repairshop, alert: "Sorry, You are not allowed for this action. Please change the user package or contat us."
			end
		end
	end

end

