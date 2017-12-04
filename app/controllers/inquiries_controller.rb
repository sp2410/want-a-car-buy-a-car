require 'emailnotifier'

class InquiriesController < InheritedResources::Base

	def new		

	end

	def create
		# session[:parent_id] = params[:parent_id]
		# session[:parent_type] = params[:parent_type]

		p params[:parent_id]
		p params[:parent_type]

		@inquiry = Inquiry.new(inquiry_params)
		@parent = get_parent(params)


		respond_to do |format|
				if @inquiry.save					
						format.html { redirect_to @parent, notice: 'Inquiry was successfuly sent!' }
			        	format.json { render :show, status: :created, location:@parent }			    	
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

  private

    def inquiry_params
      params.require(:inquiry).permit(:from_email, :to_email, :first_name, :last_name, :phone, :comment, :subject)
    end

    def get_parent(params)
    	if params[:parent_type] == "Listing"
			return Listing.find_by_id(params[:parent_id])
		elsif params[:parent_type] == "Repairshop"
			return Repairshop.find_by_id(params[:parent_id])
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

