require 'emailnotifier'

class Users::RegistrationsController < Devise::RegistrationsController
 #before_action :configure_sign_up_params, only: [:create]
 #before_action :configure_account_update_params, only: [:update]



# protected

# def sign_up_params
#     params.require(:user).permit(:email, :current_password, :password, :website, :password_confirmation, :role, :zipcode, :city, :state, :street_address, :phone_number, :name, :backgroundimage, :logoimage, :websiteheader, :websitesubheader, :websitedescription)
# end

# def account_update_params
#     params.require(:user).permit(:email, :current_password, :password, :website, :password_confirmation, :role, :zipcode, :city, :state, :street_address, :phone_number, :name, :backgroundimage, :logoimage, :websiteheader, :websitesubheader, :websitedescription)
# end

  # GET /resource/sign_up
  def new
    super
  end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  def destroy
    super
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end



# {"basic user": 0, "basic dealer": 1, "basic repairshop": 2, "silver dealer": 3, "silver repairshop": 4, "gold dealer": 5, "diamond dealer": 6}



  # The path used after sign up.
 def after_sign_up_path_for(resource)
    super(resource)
    p resource.role
   if resource.role == "BASIC USER" or resource.role == "BASIC DEALER"  or resource.role == "SILVER DEALER"
     new_listing_path(resource.id)
   elsif resource.role == "GOLD DEALER" or resource.role == "DIAMOND DEALER"         
     begin
      send_email(resource)
     rescue
      p "error in sending email"
     end
     signup_thankyou_path
     
   elsif resource.role == "BASIC REPAIRSHOP" or resource.role == "SILVER REPAIRSHOP"
    new_repairshop_path(resource.id)
   else
    root_path
   end
     
 end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private
   
  def send_email(user)
    from = 'wantacarbuyacar@tdcdigitalmedia.com'
    dealers = ['sales@tdcdigitalmedia.com', 'tech@tdcdigitalmedia.com']
    subject = "New #{user.role} #{user.email}, #{user.phone_number} signedup! "
    content = "<html><head><style type='text/css'>body,html,.body{background:#D3D3D3!important;}</style></head><body><container><spacer size='16'></spacer><row><columns large='8'><center><h2>#{subject}</h2></center></columns></row><row><columns large='6'><center><h4>Hi! Its Want a Car Buy A Car!</h4><br><p>A new priority user signed up. Please contact him/her for payments, inventory and leads. Here are his details: </p><br><p>Role: #{user.role} Email: #{user.email}, Phone: #{user.phone_number}<br> <br></p><center></columns><columns large='4'><img class='small-float-center' width='100px' height='100px' src='https://s3-us-west-2.amazonaws.com/wacbacassetsdonttouch/wacbacassets/TDC.png' alt=''></columns></row><row></row></container><body></html>"    
    @notifier = EmailNotifier.new(from, dealers, subject, content)
    @notifier.send
  end


end
