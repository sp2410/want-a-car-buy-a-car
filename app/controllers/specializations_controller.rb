class SpecializationsController < InheritedResources::Base

	before_action :authenticate_user!, only: [:new, :create, :destroy, :update]
	before_action :is_user?, only: [:new, :create, :destroy, :update]

	before_action :set_parents, only:  [:new, :create] 
	before_action :set_child_and_parents, only:  [:destroy, :update, :update, :edit]


	def new
		@specialization = Specialization.new
	end

	def edit
				
	end

	def create

		if params[:specializations]

			params[:specializations].each do |specialization|
				@specialization = Specialization.new({:title => specialization, :repairshop_id => @repairshop.id})					
				
				if !Specialization.find_by_title(specialization)
					begin
						@specialization.save!
					rescue
						p "specialization not saved"
					end
				end				
			end

			respond_to do |format|
				format.html {redirect_to @repairshop, notice: 'specializations were successfully created.'}
			end

		else

			@specialization = Specialization.new(specialization_params)	
			@specialization.repairshop_id = @repairshop.id

			respond_to do |format|
				if @specialization.save	
					format.html { redirect_to @repairshop, notice: 'specialization was successfully created.' }
			        format.json { render :show, status: :created, location:@repairshop }
				else				
					format.html { render :new }
			        format.json { render json: @specialization.errors, status: :unprocessable_entity }
				end
			end
		end

	end

	def destroy
		@specialization.destroy
		respond_to do |format|						
		    format.html { redirect_to @repairshop, notice: 'specialization  was successfully destroyed.' }
		    format.json { head :no_content }
		end

	end

	def update
		respond_to do |format|
	      	if @specialization.update(specialization_params)
		        format.html { redirect_to @repairshop, notice: 'specialization was updated.' }
		        format.json { render :show, status: :ok, location: @repairshop}
	      	else
		        format.html { render :edit }
		        format.json { render json: @specialization.errors, status: :unprocessable_entity }
	    	end
    	end
	end

	private

	 def specialization_params
      params.require(:specialization).permit(:title)
    end

    def set_child_and_parents
    	@specialization = Specialization.find_by_id(params[:id])
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
end

