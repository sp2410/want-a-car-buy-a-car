require 'emailnotifier'

class NewDealerContactsController < InheritedResources::Base

	include ApplicationHelper

	def new
	end

	def create
		@new_dealer_contact = NewDealerContact.new(new_dealer_contact_params)			
			respond_to do |format|
					if verify_recaptcha(model: @new_dealer_contact) and @new_dealer_contact.save					
							# format.html { redirect_to @parent, notice: 'Inquiry was successfuly sent!' }
							format.html { redirect_to new_new_dealer_contact_path, notice: 'Thank You! Our team will contact you very soon.'}
				        	format.json { head :ok }			    	
				        	begin
				        		send_email(@new_dealer_contact)
				        	rescue
				        		p "Email not sent"
				        	end
					else				
						format.html { redirect_to new_new_dealer_contact_path, notice: 'There was some problem sending email. Please fill all the required fields or contact us directly.' }						
				        format.json { render json:@new_dealer_contact.errors, status: :unprocessable_entity }
						
					end
			end


	end


  private

    def new_dealer_contact_params
      params.require(:new_dealer_contact).permit(:fullname, :email, :phone, :zip, :address, :city, :state, :website, :inventoryhost, :dealershipname)
    end

  #   def get_parent(params)    	
		# return contact_path		
  #   end


	def send_email(inquiry)
		from = ((inquiry.email.empty?) or (inquiry.email.nil?)) ? "noreply@tdcdigitalmedia.com" : inquiry.email		
		dealers	= ['sales@tdcdigitalmedia.com']
		subject = "#{inquiry.id} A New Customer wants to sign up!"		
		content = "<html><head><style type='text/css'>body,html,.body{background:#e8e1e1!important;}</style></head><body><container><spacer size='16'></spacer><row><columns large='8'><center><h2>New Customer wants to signup on Want A Car Buy A Car</h2></center></columns></row><row><columns large='6'><left><h4>**Please reply back to the customer using contact information below. **</h4><br><p><strong>Contact:</strong></p><p>Dealership Name: #{inquiry.dealershipname if inquiry.dealershipname}</p><p>Full Name: #{inquiry.fullname if inquiry.fullname}</p><p>Email: #{inquiry.email if inquiry.email }</p><p>Telephone: #{inquiry.phone if inquiry.phone}</p><br><p>Street Address: #{inquiry.address if inquiry.address}</p><p>Zipcode: #{inquiry.zip if inquiry.zip}</p><p>City: #{inquiry.city if inquiry.city}</p><p>State: #{inquiry.state if inquiry.state}</p><p>Website: #{inquiry.website if inquiry.website}</p><p>Inventory Host: #{inquiry.inventoryhost if inquiry.inventoryhost}</p><br></left></columns><columns large='6'><center><p><a href = 'http://www.wantacarbuyacar.com'>Want A Car Buy A Car</a></p></center></columns><columns large='4'><center><img class='small-float-center' width='100px' height='100px' src='https://s3-us-west-2.amazonaws.com/wacbacassetsdonttouch/wacbacassets/THEDEALERSCHOICElogosmall3.png' alt=''></center></columns></row></container><body></html>"		
		@notifier = EmailNotifier.new(from, dealers, subject, content)
		@notifier.send
	end
end

