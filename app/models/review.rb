class Review < ActiveRecord::Base
	belongs_to :user

	def self.get_average_rating(owner_id)
		overall_rating = Review.where('owner_id = ? and approved = ?', owner_id, true).where.not('user_id = ?', owner_id).average(:rating)		
		((overall_rating == nil) or (overall_rating == 0)) ? 5 : overall_rating.to_i

	end

	def accept_review		
		self.approved = true  		  	   	    	    
	end
end
