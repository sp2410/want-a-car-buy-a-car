ActiveAdmin.register Listing do
	active_admin_importable
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :title, :description, :city, :state, :zipcode, :category_id, :subcategory_id, :image, :year, :miles, :transmission, :color, :cylinder, :fuel, :drive, :address,:wholesale,:price, :newused, :vin, :stocknumber, :model, :trim, :enginedescription,:interiorcolor,:options, :expiration_date
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

   

	scope :diamond_dealer_listings
	scope :basic_dealer_listings
	scope :silver_dealer_listing
	scope :gold_dealer_listing
	scope :basic_user_listing


	 controller do 
    	def mark_as_approved(listing)
    		begin
    			Listing.where(:vin => listing.vin).update_all(:approved => true)
    			return true   		
    		rescue
    			return false
    		end
    			
    		
			
		end

		def mark_as_not_approved(listing)
			begin
    			Listing.where(:vin=> listing.vin).update_all(:approved => false)
    			return true   		
    		rescue
    			return false
    		end
		end
    end

    member_action :approve_listing_method, method: :get do 
    	status = mark_as_approved(resource)
    	if status 
    		redirect_to admin_listings_path, notice: "listing was marked approved"
    	else
    		redirect_to admin_listings_path, notice: "Sorry! There was an error"
    	end
    end

     member_action :hold_listing_method, method: :get do 
    	status = mark_as_not_approved(resource)
    	if status 
    		redirect_to admin_listings_path, notice: "listing was marked as not approved"
    	else
    		redirect_to admin_listings_path, notice: "Sorry! There was an error"
    	end
    end

  

	index do
		column :id
		column :vin
		column :stocknumber
		column :approved

		column "Approve listing" do |resource|
	    	link_to "Yes approve", approve_listing_method_admin_listing_path(resource)
	    end	
	    column "Hold listing" do |user|
	    	link_to "Yes put on hold", hold_listing_method_admin_listing_path(user)
	    end	

		column :wholesale

		column "Title", :title
		column "Description", :description
		column "City", :city
		column "State", :state
		column "Zipcode", :zipcode
		column "Created At", :created_at
		column "Updated At", :updated_at
		column :user_id
		column :image
		column :year
		column :miles
    	column :transmission
    	column :color
    	column :cylinder
    	column :fuel
    	column :drive
    	column :address    	
    	column :price
    	column :newused    	    
    	column :model
    	column :trim
    	column :enginedescription
    	column :interiorcolor
    	column :options
    	column :imagefront
    	column :imageback
    	column :imageleft
    	column :imageright
    	column :frontinterior
    	column :rearinterior
    	column :bodytype
    	column :make
    	
    	column :expiration_date


		

		
	    column "" do |resource|
	      links = ''.html_safe
	      links += link_to I18n.t('active_admin.edit'), edit_resource_path(resource), :class => "member_link edit_link"
	      links += link_to I18n.t('active_admin.view'), resource_path(resource), :class => "member_link view_link"
	      links += link_to I18n.t('active_admin.delete'), resource_path(resource), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
	      links
	      
	    end

	end	



end
