class TimetablesController < InheritedResources::Base

	before_action :authenticate_user!, only: [:create, :destroy, :update]
	before_action :is_user?, only: [:new, :edit, :create, :destroy, :update]	

	before_action :set_parents, only:  [:create, :update, :destroy, :edit, :new] 	


	def new
		@timetable = Timetable.new		
	end

	def edit
				
	end

	def create

			@timetable = Timetable.new(timetable_params)	
			@timetable.user_id = @user.id

			respond_to do |format|
				if @timetable.save	
					format.html { redirect_to userpage_path(:id => @user.slug), notice: 'specialization was successfully created.' }
			        #format.json { render :show, status: :created, location:@repairshop }
				else				
					format.html { render userpage_path(:id => @user.slug) }
			        #format.json { render json: @specialization.errors, status: :unprocessable_entity }
				end
			end		

	end

	def destroy
		@timetable.destroy
		respond_to do |format|						
		    format.html { redirect_to userpage_path(:id => @user.slug), notice: 'specialization  was successfully destroyed.' }
		    #format.json { head :no_content }
		end

	end

	def update
		respond_to do |format|
	      	if @timetable.update(timetable_params)
		        format.html { redirect_to userpage_path(:id => @user.slug), notice: 'Timetable was updated.' }
		        #format.json { render :show, status: :ok, location: @repairshop}
	      	else
		        format.html { redirect_to userpage_path(:id => @user.slug) }
		        #format.json { render json: @specialization.errors, status: :unprocessable_entity }
	    	end
    	end
	end

	private

	 def timetable_params
      params.require(:timetable).permit(:day, :start_time, :end_time, :user_id)
    end


    def set_parents    	
    	@user = User.where(:slug => params[:user_id]).first
    	@timetable = Timetable.find_by_id(params[:id])  

    end

    def is_user?
		@user = User.where(:slug => params[:user_id]).first
		if @user != current_user 
			redirect_to userpage_path(:id => @user.slug), alert: "Sorry, You are not the page owner"
		end
	end
	
end

