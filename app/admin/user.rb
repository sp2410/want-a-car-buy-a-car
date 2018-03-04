ActiveAdmin.register User do
	active_admin_importable

    config.filters = false
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :email, :password, :website, :password_confirmation, :role, :city, :state, :zipcode, :street_address, :phone_number, :name, :backgroundimage, :logoimage, :websiteheader, :websitesubheader, :websitedescription,:textcolor, :slug



  form do |f|
      f.inputs "User" do
        f.input :email
        f.input :name    
        f.input :password
        f.input :password_confirmation    
        f.input :role      
        f.input :street_address        
        f.input :city
        f.input :state
        f.input :zipcode
        f.input :phone_number   
        f.input :website 
        f.input :backgroundimage, as: :file
        f.input :logoimage, as: :file        
        f.input :websiteheader
        f.input :websitesubheader
        f.input :websitedescription
        f.input :textcolor  
        # f.input :slug    
      end
      f.actions
    end
# #
# or
#
# permit_params do
#   permitted = [:email, :role, :website, :zipcode, :city, :state, :street_address, :phone_number, :password, :password_confirmation]
#   permitted << :other if params[:action] == 'create'
#   permitted
# end
	scope :all_users
	scope :basic_users
    scope :basic_dealers
    scope :basic_repairshops
    scope :silver_dealers
    scope :silver_repairshops
    scope :gold_dealer
    scope :diamond_dealer

    scope :leads2deals

    #before_action :remove_password_params_if_blank, only: [:update]


    controller do 

        # def remove_password_params_if_blank
        #   if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
        #     params[:user].delete(:password)
        #     params[:user].delete(:password_confirmation)
        #   end
        # end
    	def approve_users_listings_or_repairshops(user_id)
    		begin
    			Listing.where(:user_id => user_id).update_all(:approved => true)
    			Repairshop.where(:user_id => user_id).update_all(:approved => true) 
    			return true   		
    		rescue
    			return false
    		end
    	end

    	

    	def hold_users_listings_or_repairshops(user_id)
    		begin
    			Listing.where(:user_id => user_id).update_all(:approved => false)
    			Repairshop.where(:user_id => user_id).update_all(:approved => false)
    			return true   		
    		rescue
    			return false
    		end
    	end

        def give_leadstodeals_priviliges(user_id)
            begin
                User.find_by_id(user_id).update(:leads2dealscustomer => true)
                return true         
            rescue
                return false
            end
        end

        def verify_user(user_id)
            begin
                User.find_by_id(user_id).update(:verified => true)
                return true         
            rescue
                return false
            end
        end

        def give_tdcfinance_priviliges(user_id)
            begin
                User.find_by_id(user_id).update(:tdcfinance => true)
                return true         
            rescue
                return false
            end
        end
    end

    member_action :approve_users_listings_or_repairshops_method, method: :get do 
    	status = approve_users_listings_or_repairshops(resource.id)
    	if status 
    		redirect_to admin_users_path, notice: "Users Listings and Repairshops were approved"
    	else
    		redirect_to admin_users_path, notice: "there was some error while approving this user's listings/repairshops"
    	end
    end

     member_action :hold_users_listings_or_repairshops_method, method: :get do 
    	status = hold_users_listings_or_repairshops(resource.id)
    	if status 
    		redirect_to admin_users_path, notice: "Users Listings and Repairshops were put on hold"
    	else
    		redirect_to admin_users_path, notice: "there was some error while putting hold on this user's listings/repairshops"
    	end
    end

    member_action :give_leadstodeals_priviliges_method, method: :get do 
        status = give_leadstodeals_priviliges(resource.id)
        if status 
            redirect_to admin_users_path, notice: "User given leads to deals leads"
        else
            redirect_to admin_users_path, notice: "There was some error while converting this user to leads to deals"
        end
    end

    member_action :verify_user_method, method: :get do 
        status = verify_user(resource.id)
        if status 
            redirect_to admin_users_path, notice: "User Verified"
        else
            redirect_to admin_users_path, notice: "There was some error while converting this user"
        end
    end

    member_action :give_tdcfinance_priviliges_method, method: :get do 
        status = give_tdcfinance_priviliges(resource.id)
        if status 
            redirect_to admin_users_path, notice: "User is now TDC Finance user"
        else
            redirect_to admin_users_path, notice: "There was some error while converting this user"
        end
    end





    index do
		column :id
		column "Email", :email
        column "Name", :name
		column "Role", :role 

		
	    column "Number of Listings" do |resource|
	    	resource.number_of_listings
	    end

	    column "Number of Repairshops" do |resource|
	    	resource.number_of_repairshops
	    end

	    column "Approve Users Listings/Repairshops" do |user|
	    	link_to "Yes approve all", approve_users_listings_or_repairshops_method_admin_user_path(user)
	    end

	    column "Hold all users Listings/Repairshops" do |user|
	    	link_to "Yes hold all", hold_users_listings_or_repairshops_method_admin_user_path(user)
	    end

        column :verified
        column :leads2dealscustomer        
        column :tdcfinance 

        column "Verified user" do |user|
            link_to "Yes Verified",  verify_user_method_admin_user_path(user)
        end

        column "Convert user to leads 2 deals customer" do |user|
            link_to "Yes convert User",  give_leadstodeals_priviliges_method_admin_user_path(user)
        end

        column "Convert user to TDC Finance customer" do |user|
            link_to "Yes convert User",  give_tdcfinance_priviliges_method_admin_user_path(user)
        end

    
	
		column "Website", :website 
		column "Zipcode", :zipcode
		column "City", :city
		column "State", :state
		column "Street address", :street_address
		column "Phone", :phone_number

	    column "" do |resource|
	      links = ''.html_safe
	      links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
	      links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link"
	      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
	      links
	      
	    end

	end	



end



    