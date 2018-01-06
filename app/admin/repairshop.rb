ActiveAdmin.register Repairshop do
	active_admin_importable

	permit_params :title, :description, :city, :state, :zipcode, :phone, :image, :approved


# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

	scope :silver_repairshops
	scope :diamond_repairshops
	scope :basic_repairshops

	

	 controller do 
    	def mark_as_approved(repairshop)
    		
    			repairshop.approved = true
    			repairshop.save! ? true : false
    		
			
		end

		def mark_as_not_approved(repairshop)
			
    			repairshop.approved = false
    			repairshop.save! ? true : false
    			 			
    		
		end
    end

    member_action :approve_repairshop_method, method: :get do 
    	status = mark_as_approved(resource)
    	if status 
    		redirect_to admin_repairshops_path, notice: "Repairshop was marked approved"
    	else
    		redirect_to admin_repairshops_path, notice: "Sorry! There was an error"
    	end
    end

     member_action :hold_repairshop_method, method: :get do 
    	status = mark_as_not_approved(resource)
    	if status 
    		redirect_to admin_repairshops_path, notice: "Repairshop was marked as not approved"
    	else
    		redirect_to admin_repairshops_path, notice: "Sorry! There was an error"
    	end
    end

    index do		
		column :id
		column :title
		column :approved
		column "Approve Repairshop" do |user|
	    	link_to "Yes approve", approve_repairshop_method_admin_repairshop_path(user)
	    end	
	    column "Hold Repairshop" do |user|
	    	link_to "Yes put on hold", hold_repairshop_method_admin_repairshop_path(user)
	    end		
	    column :description
	    column :city
	    column :state
	    column :zipcode
	    column :phone
	    column :created_at
	    column :updated_at
	    column :latitude
	    column :longitude
	   	column :user_id
	    column :image
	   	column :category_id
	end
	



	
    

end
