class RepairshopsController < InheritedResources::Base

	before_filter :authenticate_user!, only: [:new, :create, :destroy, :update, :edit]
	#before_filter :is_user?, only: [:edit, :update, :delete]


	def index
		@repairshops = Repairshop.all
	end	

	def new
		@repairshop = Repairshop.new
	end

	def create
		@repairshop = Repairshop.new(repairshop_params)
		@repairshop.user = current_user

		if @repairshop.save			
			redirect_to @repairshop
		else
			flash[:alert] =  @repairshop.errors.full_messages.to_sentence
			render 'new'
		end
	end

	def show
		@repairshop = Repairshop.find(params[:id])	
		@desc = @repairshop.description.split(',')	
	end

	def update
		@repairshop = Repairshop.find(params[:id])		
		@repairshop.update(repairshop_params)
		
		if @repairshop.update(repairshop_params)
			redirect_to @repairshop
		else 
			flash[:alert] =  "Sorry Couldn't Update right now"
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
		@repairshop = Repairshop.search(params)
	end


  private

    def repairshop_params
      params.require(:repairshop).permit(:title, :description, :city, :state, :zipcode, :phone, :image)
    end
end

