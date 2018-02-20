require 'emailnotifier'

class InquiriesController < InheritedResources::Base
	include ApplicationHelper

	def new		

	end

	def create

		@parent = get_parent(params)

		if params[:dealers]
			begin
				NewInquiryCreator.perform_async(params[:dealers], inquiry_params)

				respond_to do |format|
					format.html {redirect_to @parent, notice: 'This process has started in the background. Please wait a little to see changed'}
				end				
			rescue
				respond_to do |format|
					format.html {redirect_to @parent, notice: 'There was some error with the leads creation.'}
				end	
			end

		else

			@inquiry = Inquiry.new(inquiry_params)			
			respond_to do |format|
					if @inquiry.save					
							# format.html { redirect_to @parent, notice: 'Inquiry was successfuly sent!' }
							format.html { redirect_to get_affiliates }
				        	format.json { head :ok }			    	
				        	begin
				        		send_email(@inquiry)
				        	rescue
				        		p "Inquiry Email not sent"
				        	end
					else				
						format.html { render @parent }						
				        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
					end
			end

		end
		

	end

	#old create

	# def create
	# 	# session[:parent_id] = params[:parent_id]
	# 	# session[:parent_type] = params[:parent_type]

	# 	# p params[:parent_id]
	# 	# p params[:parent_type]
	# 	@parent = get_parent(params)

	# 	if params[:dealers]

	# 		all_saved = true
	# 		buffer_array_of_cloned_inquiries = Array.new

	# 		if params[:dealers].include? "allleads2deals"
	# 			(User.leads2deals.emails).each do |dealer|
	# 				@inquiry = Inquiry.new(inquiry_params.merge(:to_email => dealer))	
	# 				@inquiry.senttoall = true

	# 				buffer_array_of_cloned_inquiries << @inquiry

	# 				if !@inquiry.save
	# 					all_saved = false
	# 				end	
										
	# 			end	

	# 			# begin
	# 			# 	Inquiry.create(buffer_array_of_cloned_inquiries)
	# 			# rescue
	# 			# 	all_saved = false
	# 			# end			
	# 		else
	# 			buffer_array_of_new_inquiries = Array.new 

	# 			params[:dealers].each do |dealer|
	# 				@inquiry = Inquiry.new(inquiry_params.merge(:to_email => dealer))
	# 				buffer_array_of_new_inquiries << @inquiry					
	# 				if !@inquiry.save
	# 					all_saved = false
	# 				end
	# 				# begin
	# 				# 	Inquiry.create(buffer_array_of_new_inquiries)
	# 				# rescue
	# 				# 	all_saved = false
	# 				# end	

								
	# 			end

	# 		end

	# 		if all_saved
	# 			respond_to do |format|
	# 				format.html {redirect_to @parent, notice: 'Leads were successfuly sent!'}
	# 			end
	# 		else
	# 			respond_to do |format|
	# 				format.html {redirect_to @parent, notice: 'There was some problems sending the leads!'}
	# 			end
	# 		end

			

	# 	else

	# 		@inquiry = Inquiry.new(inquiry_params)			


	# 		respond_to do |format|
	# 				if @inquiry.save					
	# 						format.html { redirect_to @parent, notice: 'Inquiry was successfuly sent!' }
	# 			        	format.json { head :ok }			    	
	# 			        	begin
	# 			        		send_email(@inquiry)
	# 			        	rescue
	# 			        		p "Inquiry Email not sent"
	# 			        	end
	# 				else				
	# 					format.html { render @parent }
	# 			        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
	# 				end
	# 		end

	# 	end
		

	# end


	def update
		
		@inquiry = Inquiry.find_by_id(params[:id])
		@parent = get_parent(params)


		respond_to do |format|
				if @inquiry.update(inquiry_params)					
						format.html { redirect_to @parent, notice: 'Inquiry was successfuly updated!' }
			        	format.json {head :ok }			    				        	
				else				
					format.html { render @parent }
			        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
				end
		end

	end



	def send_to_all

		@parent = get_parent(params)		

		@old_inquiry = Inquiry.find_by_id(params[:id])

		#buffer_array_of_cloned_inquiries = Array.new

		if !@old_inquiry.senttoall			

			begin
				CloneInquiryCreator.perform_async(params[:id])	
				respond_to do |format|
					format.html {redirect_to @parent, notice: 'This process has started in the background. Please wait a little to see changed'}
				end				
			rescue
				respond_to do |format|
					format.html {redirect_to @parent, notice: 'There was some error with the leads creation.'}
				end	
			end
			
		else
			respond_to do |format|
				format.html {redirect_to @parent, notice: 'This lead was already sent to all Leads 2 Deals Customers'}
			end
		end


		

	end


	#old send to all

	# def send_to_all
	# 	p params[:parent_id]
	# 	p params[:parent_type]
	# 	p params[:id]

	# 	@parent = get_parent(params)

	# 	all_saved = true		

	# 	@old_inquiry = Inquiry.find_by_id(params[:id])

	# 	#buffer_array_of_cloned_inquiries = Array.new

	# 	if !@old_inquiry.senttoall			

	# 		(User.leads2deals.emails - [@old_inquiry.to_email]).each do |dealer|
	# 			@inquiry = @old_inquiry.dup
	# 			@inquiry.to_email = dealer			
	# 			@inquiry.senttoall = true
	# 			#buffer_array_of_cloned_inquiries << @inquiry

	# 			if !@inquiry.save
	# 				all_saved = false
	# 			end		
	# 		end

	# 		# begin
	# 		# 	Inquiry.create(buffer_array_of_cloned_inquiries)
	# 		# rescue
	# 		# 	all_saved = false
	# 		# end
	

	# 		if all_saved

	# 			@old_inquiry.senttoall = true
	# 			@old_inquiry.save

	# 			respond_to do |format|
	# 				format.html {redirect_to @parent, notice: 'All Leads were successfuly sent!'}
	# 			end
	# 		else
	# 			respond_to do |format|
	# 				format.html {redirect_to @parent, notice: 'There was some problems sending all the leads! Try sending one by one'}
	# 			end
	# 		end
	# 	else
	# 		respond_to do |format|
	# 			format.html {redirect_to @parent, notice: 'This lead was already sent to all Leads 2 Deals Customers'}
	# 		end
	# 	end


		

	# end




  private

    def inquiry_params
      params.require(:inquiry).permit(:from_email, :to_email, :first_name, :last_name, :phone, :comment, :subject, :status, :senttoall, :referredby)
    end

    def get_parent(params)
    	if params[:parent_type] == "Listing"
			return Listing.find_by_id(params[:parent_id])
		elsif params[:parent_type] == "Repairshop"
			return Repairshop.find_by_id(params[:parent_id])
		elsif params[:parent_type] == "User"
			return userpage_path(:slug => User.where(:id => params[:parent_id]).slug)
		else
			return root_path
		end
    end


	def send_email(inquiry)
		from = 'sales@tdcdigitalmedia.com'
		dealers	= [inquiry.to_email]
		subject = inquiry.subject
		content = "<html><head><style type='text/css'>body,html,.body{background:#D3D3D3!important;}</style></head><body><container><spacer size='16'></spacer><row><columns large='8'><center><h2>#{inquiry.subject}</h2></center></columns></row><row><columns large='6'><center><h4>Hi! Its Want a Car Buy A Car!</h4><br><p>A user inquired about your listing. Here are his details: </p><br><p>From: #{inquiry.from_email}, First Name: #{inquiry.first_name}, Last Name: #{inquiry.last_name}, Phone: #{inquiry.phone}<br> Message:#{inquiry.comment}<br></p><center></columns><columns large='6'><br><p>For any help, contact our sales team at: Phone: +1 866-338-7870 Line 5</p><br><p>Our Email:sales@tdcdigitalmedia.com</p></columns><columns large='4'><img class='small-float-center' width='100px' height='100px' src='https://s3-us-west-2.amazonaws.com/wacbacassetsdonttouch/wacbacassets/TDC.png' alt=''></columns></row><row></row></container><body></html>"		
		@notifier = EmailNotifier.new(from, dealers, subject, content)
		@notifier.send
	end

end

