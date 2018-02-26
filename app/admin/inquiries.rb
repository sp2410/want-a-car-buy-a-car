ActiveAdmin.register Inquiry do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :from_email, :to_email, :first_name, :last_name, :phone, :comment, :subject, :status, :senttoall, :referredby
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

		
		scope :ALL
		scope :FRESH
		scope :CONTACTED
		scope :APPOINTMENT
		scope :WORKINGDEAL
		scope :MISSEDAPPOINTMENTFOLLOWUP
		scope :DEALERVISITFOLLOWUP
		scope :BOUGHTHERE
		scope :DEADDEAL
		scope :DONOTCALL
		scope :BOUGHTELSEWHERE
		scope :ONHOLD

		scope :sent_to_all
		scope :individual
		



 	controller do 
 		#old
  #   	def send_to_all(inquiry)
  #   		all_saved = true

  #   		begin
	 #    		old_inquiry = Inquiry.find_by_id(inquiry)

	 #    		return false if old_inquiry.senttoall

	 #    		if !old_inquiry.senttoall			

		# 			(User.leads2deals.emails - [old_inquiry.to_email]).each do |dealer|
		# 				new_inquiry = old_inquiry.dup
		# 				new_inquiry.to_email = dealer			
		# 				new_inquiry.senttoall = true
		# 				#buffer_array_of_cloned_inquiries << @inquiry

		# 				if !new_inquiry.save
		# 					all_saved = false
		# 				end		
		# 			end
		# 		end

  #   			return all_saved  		
  #   		rescue
  #   			return false
  #   		end
 
		# end

		def send_to_all(inquiry)
			begin
				CloneInquiryCreator.perform_async(inquiry.id)	
				return true			
			rescue
				return false
			end
		end

		def resend_to_all(inquiry)
			begin
				ResendInquiryCreator.perform_async(inquiry.id)	
				return true			
			rescue
				return false
			end
		end

		def contact_customer(inquiry)
			begin
				SendEmail.perform_async("Are You still looking for a vehicle ? Let us help. | Want A Car Buy A Car", "Hi! We saw that you inquired about a vehicle on our website www.wantacarbuyacar.com on #{inquiry.created_at}. We informed the dealership right away about your interest, and I wanted to reach out and see if you bought a vehicle from them and would be interested in giving them a review in order to redeem a complimentary $5 Gas or Grocery Card. If you did not buy a vehicle and are still looking, then please let me know and I will help you find the perfect vehicle. You can just reply back to this email to reach me.", ["#{inquiry.from_email}"])
            	# send_contact_email("Are You still looking for a vehicle ? Let us help. | Want A Car Buy A Car", "Hi! We saw that you raised an inquiry on our website www.wantacarbuyacar.com on #{inquiry.created_at}. We informed the dealership right away but wanted to get in touch with you in person to help your demand reach all the dealerships around you. Please let us know if you are still looking for a vehicle.", ["#{inquiry.from_email}"])        
            	return true
	        rescue
	        	return false
	        end
		end
 		
		
    end

    member_action :send_to_all_action, method: :get do 
    	status = send_to_all(resource)
    	if status 
    		redirect_to admin_inquiries_path, notice: "Great! This job has been added to the background. Leads will be sent to all"
    	else
    		redirect_to admin_inquiries_path, notice: "There was some error sending leads (this inquiry) to all, either it was already sent or the copies couldnt be created"
    	end
    end

    member_action :resend_to_all_action, method: :get do 
    	status = resend_to_all(resource)
    	if status 
    		redirect_to admin_inquiries_path, notice: "Great! This job has been added to the background. Leads will be sent to all"
    	else
    		redirect_to admin_inquiries_path, notice: "There was some error sending leads (this inquiry) to all, either it was already sent or the copies couldnt be created"
    	end
    end

    member_action :contact_customer_action, method: :get do 
    	status = contact_customer(resource)
    	if status 
    		redirect_to admin_inquiries_path, notice: "Great! An email was sent to the customer. You can also reach out directly to: #{resource.from_email if resource.from_email}, phone: #{resource.phone if resource.phone}"
    	else
    		redirect_to admin_inquiries_path, notice: "Error in sending the email to the customer. Please reach out directly to #{resource.from_email if resource.from_email}, phone: #{resource.phone if resource.phone}"
    	end
    end




	index do
		column :id
		column :from_email
		column :to_email			   
		column :first_name

		column :last_name
		column :phone
		column :comment
		column :subject	

		column :senttoall

		column "Leads 2 deals (If not sent)" do |resource|
	    	link_to "Send To All", send_to_all_action_admin_inquiry_path(resource)	    	
	    end	

	    column "Leads 2 deals (Resend)" do |resource|
	    	link_to "Resend To All", resend_to_all_action_admin_inquiry_path(resource)
	    end

	    column "Email Customer if still looking for vehicle" do |resource|
	    	link_to "Yes, send the email", contact_customer_action_admin_inquiry_path(resource)
	    end

	    

	    column "" do |resource|
	      links = ''.html_safe
	      links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
	      links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link"
	      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
	      links
	      
	    end

	   
	end	

end
