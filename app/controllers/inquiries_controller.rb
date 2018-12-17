require 'emailnotifier'

class InquiriesController < InheritedResources::Base
	include ApplicationHelper

	def new		

	end

	def create

		@parent = get_parent(params)

		if params[:dealers]
			respond_to do |format|
				if  ( verify_recaptcha(model: Inquiry.new) and inquiry_params[:first_name].present? and inquiry_params[:phone].present?)

					begin
						NewInquiryCreator.perform_async(params[:dealers], inquiry_params)
						format.html {redirect_to @parent, notice: 'Thanks! This lead has been sent.'}
									
					rescue
						
						format.html {redirect_to @parent, notice: 'There was some error with the leads creation. Please fill in the required fields'}
						
					end
				else					
					format.html { redirect_to @parent, notice: 'Oops! Please fill in all the required fields' }			
				end
			end

		else

			@inquiry = Inquiry.new(inquiry_params)					
			respond_to do |format|			
			# verify_recaptcha(model: @inquiry) and	
					if  verify_recaptcha(model: @inquiry) and @inquiry.save									
							# format.html { redirect_to @parent, notice: 'Inquiry was successfuly sent!' }
							format.html { redirect_to get_affiliates }
				        	format.json { head :ok }			    	
				        	begin
				        		send_email(@inquiry)
				        	rescue
				        		p "Inquiry Email not sent"
				        	end
					else				
						format.html { redirect_to @parent, notice: 'Oops! Please fill in all the required fields' }												
				        format.json { render json: @inquiry.errors, status: :unprocessable_entity }
					end
			end
		end		
	end

	def update
		@inquiry = Inquiry.find_by_id(params[:id])
		@parent = get_parent(params)
		@inquiry.attributes = inquiry_params

		respond_to do |format|
				if @inquiry.save(:validate => false)					
					# if @inquiry.update(inquiry_params)																	
					format.html { redirect_to @parent, notice: 'Inquiry was successfuly updated!' }
			        format.json {head :ok }

			        begin
						if @inquiry.status == 'Bought_Here'
							user = User.find_by_email(@inquiry.to_email)	
							name = user.name || user.email														
							BoughtHereNotifications.perform_async("Hi! #{user.name} converted a lead to deal.", "Good News! #{user.name} converted lead id #{@inquiry.id} to a deal. Please charge them accordingly.", ['sales@tdcdigitalmedia.com'])																
						end	
					rescue											
							
					end	

				else				
					format.html { redirect_to @parent, notice: "There was some error updating" }
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
					format.html {redirect_to @parent, notice: 'Great! This lead has been sent. '}
				end				
			rescue
				respond_to do |format|
					format.html {redirect_to @parent, notice: 'Oops! There was some error with the leads creation.'}
				end	
			end
			
		else
			respond_to do |format|
				format.html {redirect_to @parent, notice: 'Wait! This lead was already sent to all Leads 2 Deals Customers'}
			end
		end


		

	end



  private

    def inquiry_params
      params.require(:inquiry).permit(:from_email, :to_email, :first_name, :last_name, :phone, :comment, :subject, :status, :senttoall, :referredby, :offer)
    end

    def get_parent(params)
    	if params[:parent_type] == "Listing"
			return Listing.find_by_id(params[:parent_id])
		elsif params[:parent_type] == "Repairshop"
			return Repairshop.find_by_id(params[:parent_id])
		elsif params[:parent_type] == "User"
			#return User.where(:id => params[:parent_id])
			return userpage_path(:id => User.where(:id => params[:parent_id]).first.slug)
		elsif params[:parent_type] == "Contact"
			return contact_path
		else
			return root_path
		end
    end


	def send_email(inquiry)
		from = ((inquiry.from_email.empty?) or (inquiry.from_email.nil?)) ? "none@tdcdigitalmedia.com" : inquiry.from_email
		#p from		
		dealers	= [inquiry.to_email]

		if inquiry.to_email.present?
			user = User.find_by_email(inquiry.to_email)
			if user.leademail1.present?
				dealers << user.leademail1
			end 
			if user.leademail2.present?
				dealers << user.leademail2
			end 
		end

		subject = "New Lead From Want A Car Buy A Car"
		#inquiry.subject
		content = "<html><head><style type='text/css'>body,html,.body{background:#e8e1e1!important;}</style></head><body><container><spacer size='16'></spacer><row><columns large='8'><center><h2>New Lead From Want A Car Buy A Car</h2></center></columns></row><row><columns large='6'><left><h4>**Please reply back to the customer using contact information below. **</h4><br><p><strong>Contact:</strong></p><p>Subject: #{inquiry.subject if inquiry.subject}</p><p>First Name: #{inquiry.first_name if inquiry.first_name}</p><p>Last Name: #{inquiry.last_name if inquiry.last_name}</p><p>Email: #{inquiry.from_email if inquiry.from_email }</p><p>Telephone: #{inquiry.phone if inquiry.phone}</p><br><p>Comments: #{inquiry.comment if inquiry.comment}</p><br> </left></columns><columns large='6'><left><p>**Want even more exposure on <a href = 'http://www.wantacarbuyacar.com'>Want A Car Buy A Car</a>? Try our premium display options. Call us at +1 866-338-7870 Line 5 or email us for more info. **</p></left></columns><columns large='6'><left><p>**Check out <a href = 'http://the-dealers-choice.com/'>The Dealers Choice</a> for more programs**</p></center></left><columns large='6'><center><p>For assistance, contact us at: Phone: +1 866-338-7870 Line 5, Email:sales@tdcdigitalmedia.com</p></center></columns><columns large='6'><center><p><a href = 'http://www.wantacarbuyacar.com'>Want A Car Buy A Car</a></p></center></columns><columns large='4'><center><img class='small-float-center' width='100px' height='100px' src='https://s3-us-west-2.amazonaws.com/wacbacassetsdonttouch/wacbacassets/THEDEALERSCHOICElogosmall3.png' alt=''></center></columns></row></container><body></html><xml><?ADF VERSION '1.0'?><?XML VERSION '1.0'?><adf><prospect><requestdate>#{inquiry.created_at}</requestdate><vehicle interest='buy'></vehicle><customer><contact><comments>Subject: #{inquiry.subject if inquiry.subject}, Comment: #{inquiry.comment if inquiry.comment}</comments><name part='first'>#{inquiry.first_name if inquiry.first_name}</name><name part='last'>#{inquiry.last_name if inquiry.last_name}</name><email>#{inquiry.from_email if inquiry.from_email }</email><phone>#{inquiry.phone if inquiry.phone}</phone></contact></customer><vendor><contact><email>#{inquiry.to_email if inquiry.to_email}</email></contact><contact><email>#{user.leademail1 if user.leademail1 }</email></contact><contact><email>#{user.leademail2 if user.leademail2 }</email></contact></vendor></prospect></adf></xml>"		
		@notifier = EmailNotifier.new(from, dealers, subject, content)
		@notifier.send
	end

end