class ReviewsController < InheritedResources::Base
  
	before_action :authenticate_user!, only: [:new, :create, :destroy, :update]	

	# before_action :get_parent, only:  [:new]
	before_action :set_child_and_parent, only:  [:destroy, :update, :edit, :raise_appeal]

	
	
	def new
		@review = Review.new				
		session[:parent_id] = params[:parent_id]
		session[:parent_type] = params[:parent_type]
		@parent = get_parent(params[:parent_type], params[:parent_id])		
		@owner = User.find_by_id(@parent.user_id)		
	end

	def edit
		session[:parent_id] = params[:parent_id]
		session[:parent_type] = params[:parent_type]
	end

	def create		
		@review = Review.new(review_params)			
		@review.user_id = current_user.id
		@parent = get_parent(session[:parent_type], session[:parent_id])
		@owner = User.find_by_id(@parent.user_id)		
		@review.owner_id = @owner.id

		if @review.owner_id	 == @review.user_id
			redirect_to @parent, notice: "No! You can't give yourself a rating." 
			return
		end
						
		respond_to do |format|
			if @review.save	
				format.html { redirect_to @parent, notice: 'Review was successfully created.' }
		        format.json { render :show, status: :created, location:@review }
			else				
				format.html { render :new }
		        format.json { render json: @review.errors, status: :unprocessable_entity }
			end
		end
	end

	def update

		@parent = get_parent(session[:parent_type], session[:parent_id])

		respond_to do |format|
	      	if @review.update(review_params)
		        format.html { redirect_to @parent, notice: 'Review was updated.' }
		        format.json { render :show, status: :ok, location: @parent}
	      	else
		        format.html { render :edit }
		        format.json { render json: @review.errors, status: :unprocessable_entity }
	    	end
    	end
	end


	def destroy		
		session[:parent_id] = params[:parent_id]
		session[:parent_type] = params[:parent_type]
		
		@parent = get_parent(session[:parent_type], session[:parent_id])		

		@review.destroy
		respond_to do |format|						
		    format.html { redirect_to @parent, notice: 'Review  was successfully destroyed.' }
		    format.json { head :no_content }
		end
	end

	def raise_appeal
		session[:parent_id] = params[:parent_id]
		session[:parent_type] = params[:parent_type]

		@parent = get_parent(session[:parent_type], session[:parent_id])
		@review.appeal = true

		respond_to do |format|
	      	if @review.save!
		        format.html { redirect_to @parent, notice: 'An appeal was raised against this review. Our team will look into this matter.' }
		        format.json { render :show, status: :ok, location: @parent}
	      	else
		        format.html { render :edit }
		        format.json { render json: @review.errors, status: :unprocessable_entity }
	    	end
    	end


	end
	
	private

	def review_params		
      	params.require(:review).permit(:comment, :rating, :appeal)
    end

    def set_child_and_parent    	
    	@review = Review.find_by_id(params[:id])
    	@owner = User.find_by_id(params[:user_id])    	
    end    

    def get_parent(parent_type, parent_id)
	    if parent_type == "repairshop"
			parent = Repairshop.find_by_id(parent_id.to_i)
		elsif parent_type == "listing"
			parent = Listing.find_by_id(parent_id.to_i)
		else
			parent = root_path
		end

		parent
    end
    

    
   
end
