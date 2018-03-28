class PagesController < ApplicationController

	#before_action :authenticate_user!, only: [:oodleimport]
	
	def help
	end

	def scams
	end

	def safety
	end

	def terms
	end

	def policy
	end

	def about
	end

	def contact
		@parent_type = "Contact"
	end

	def signup_thankyou
	end
	
	def dealercorner
	end

	def loadtesting
	end

	def oodleimport		

		#if current_user_is_sales_team
			respond_to do |format|
				format.csv{ send_data Listing.export_oodle("oodle")}
			end 
		#else 
			#redirect_to root_path, alert: "Sorry, You are not allowed for this action."
		#end 

		
	end

end
