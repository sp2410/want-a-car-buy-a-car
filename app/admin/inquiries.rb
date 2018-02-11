ActiveAdmin.register Inquiry do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :from_email, :to_email, :first_name, :last_name, :phone, :comment, :subject, :status, :senttoall
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
		
    end

    member_action :send_to_all_action, method: :get do 
    	status = send_to_all(resource)
    	if status 
    		redirect_to admin_inquiries_path, notice: "Great! This job has been added to the background. Leads will be sent to all"
    	else
    		redirect_to admin_inquiries_path, notice: "There was some error sending leads (this inquiry) to all, either it was already sent or the copies couldnt be created"
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

		column "Leads 2 deals" do |resource|
	    	link_to "Send To All", send_to_all_action_admin_inquiry_path(resource)
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
