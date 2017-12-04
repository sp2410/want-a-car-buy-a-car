module ApplicationHelper

  	def user_is_listing_owner(listing)
        if user_signed_in?
          if listing.user_id == current_user.id
              return true
          end
        end

        return false
    end

    def user_is_review_owner(review)
      if user_signed_in?
        return true if (review.user_id == current_user.id)
      end

      return false
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
