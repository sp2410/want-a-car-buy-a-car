class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
#  include Pundit
 	protect_from_forgery with: :exception  
	 
 	before_filter :configure_permitted_parameters, if: :devise_controller?

  	protected

  	def configure_permitted_parameters
  		#devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  		#devise_parameter_sanitizer.for(:sign_up) + [:email, :password, :website, :password_confirmation, :role]
  		#devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email, :password, :website, :password_confirmation, :role) }


    	devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :website, :password_confirmation, :role, :city, :state, :zipcode, :street_address, :phone_number])
    	#devise_parameter_sanitizer.permit(:sign_up, :website)

    	devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :website, :password_confirmation, :role, :city, :state, :zipcode, :street_address, :phone_number])
    	#devise_parameter_sanitizer.permit(:account_update, :website)
  	end
  	  
  

  #before_filter :authenticate_user!, :except=>[:new, :create]

#  before_action :configure_permitted_parameters, if: :devise_controller?

 # protected

  #def configure_permitted_parameters
    ## To permit attributes while registration i.e. sign up (app/views/devise/registrations/new.html.erb)    
#	devise_parameter_sanitizer.permit(:sign_up, :role)
    ## To permit attributes while editing a registration (app/views/devise/registrations/edit.html.erb)    
 #   devise_parameter_sanitizer.permit(:account_update, :role)
#  end
#params.require(:user).permit(:email, :password, :password_confirmation, :role)
 
  

end
