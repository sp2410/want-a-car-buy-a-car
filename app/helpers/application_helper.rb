module ApplicationHelper

   def user_has_paid(listing)
      listing_is_live(listing) ? true : false
    end

  	def user_is_listing_owner(listing)
        if user_signed_in?
          if listing.user_id == current_user.id
              return true
          end
        end

        return false
    end

    def listing_is_live(listing)
      false
    end

    def user_is_review_owner(review)
      if user_signed_in?
        return true if (review.user_id == current_user.id)
      end

      return false
    end

    def get_paypal_button(user)
      user_role = user.role 

      if user_role == "BASIC USER"
        render partial: "pages/paypal_basic_user" 
        
      elsif user_role == "BASIC DEALER"
        render partial: "pages/paypal_basic_dealer" 
        
      elsif user_role == "BASIC REPAIRSHOP"
        render partial: "pages/paypal_basic_repairshop" 
        
      elsif user_role == "SILVER DEALER"
        render partial: "pages/paypal_silver_dealer" 
        
      elsif user_role == "SILVER REPAIRSHOP"
        render partial: "pages/paypal_silver_repairshop" 
        
      elsif user_role == "GOLD DEALER"
        render partial: "pages/paypal_gold_dealer" 
        
      elsif user_role == "DIAMOND DEALER"
        render partial: "pages/paypal_diamond_dealer" 
        
      end     
    end



    def user_has_basic_dealer_access(user)
      user.role == 'USER' ? true : false
    end
        
    def user_has_silver_dealer_access(user)
      user.role == 'SILVER' ? true : false
    end

    def user_has_gold_dealer_access(user)      
      user.role == 'GOLD' ? true : false
    end

    def user_has_diamond_access(user)
      user.role == 'DIAMOND' ? true : false    
    end
    

    def user_has_basic_repairshop_access(user)
      user.role == 'REPAIRSHOP' ? true : false
    end

    def user_has_perl_repairshop_access(user)
      user.role == 'PEARL' ? true : false
    end



    def sortable(column, title = nil)
      title ||= column.titleize
      css_class = column == sort_column ? "current #{sort_direction}" : nil
      direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"      
      # link_to title, request.params.merge({:sort => column, :direction => direction, :page => nil}), {:class => "css_class" }
      link_to title, params.permit(:min, :max, :radius, :startdate, :near).merge({:sort => column, :direction => direction, :page => nil}), {:class => "css_class" }
    end


    def addfilters(column, title)      
      link_to title, params.permit(:NewUsed, :category, :subcategory, :minprice, :maxprice, :location, :radius).merge({:"#{column}" => "1990"})
    end


    def user_is_premium_or_repairshop
      if user_signed_in?
        if (current_user.role.eql? "premium") or (current_user.role.eql? "repairshop") 
          return true
        end
      end

      return false
    end      

    def get_rating_in_star(rating)
      rating = case rating 

      when 1
        then render partial: "layouts/rating1star" 
      when 2
        then render partial: "layouts/rating2star"        
      when 3
        then render partial: "layouts/rating3star"        
      when 4
        then render partial: "layouts/rating4star"        
      when 5
        then render partial: "layouts/rating5star"        
      end
      return rating

    end


end
