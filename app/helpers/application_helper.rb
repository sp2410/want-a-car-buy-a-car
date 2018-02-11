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

    def user_is_webpage_owner(user_id)
      if user_signed_in?
          if user_id == current_user.id
              return true
          end
        end

        return false
    end

    def user_is_comment_owner(comment)
        if user_signed_in?
          if comment.comment_by == current_user.id
              return true
          end
        end

        return false
    end

     def current_user_is_sales_team
      if user_signed_in?
          if current_user.user_is_sales_team
              return true
          end
        end

        return false
    end

    def owner_is_sales_team(user)        
          if user.user_is_sales_team
              return true
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


    def user_is_diamond_or_repairshop
      unless current_user.nil?       
        (current_user.user_can_create_repairshop == true) ? true : false
      else
        true
      end
    end      

    def user_is_basic_user
      unless current_user.nil?       
        (current_user.user_can_create_listing == true) ? true : false
      else
        true
      end
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

    def can_view_wholesale
      unless current_user.nil?       
        (current_user.user_can_view_wholesale == true) ? true : false
      else
        false
      end
    end

    def can_add_wholesale
      unless current_user.nil?       
        (current_user.user_can_add_wholesale == true) ? true : false
      else
        false
      end
    end



end
