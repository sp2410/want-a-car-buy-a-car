ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

    div class: "blank_slate_container", id: "dashboard_default_message" do
      span class: "blank_slate" do
        span "Welcome To Want A Car Buy A Car Backend!"        
        small "Use options below for CSV below:"   
      end
    end

    

    # columns do
    #   column do
    #     panel "CSV Uploads for Listings" do
    #       ul do
            
                       
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "CSV Uploads for Repairshops"
    #     end
    #   end
    # end

    # columns do
    #   column do
    #     panel "CSV Uploads for Dealers" do
    #       ul do
    #         # Listing.recent(5).map do |post|
    #         #   li link_to(post.title, admin_listing_path(post))
    #         # end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

    # columns do
    #   column do
    #     panel "CSV Uploads for Listings" do
    #       ul do
    #         # Listing.recent(5).map do |post|
    #         #   li link_to(post.title, admin_listing_path(post))
    #         # end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

    # columns do
    #   column do
    #     panel "CSV Uploads for Listings" do
    #       ul do
    #         # Listing.recent(5).map do |post|
    #         #   li link_to(post.title, admin_listing_path(post))
    #         # end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end

  end # content
 
    
end
