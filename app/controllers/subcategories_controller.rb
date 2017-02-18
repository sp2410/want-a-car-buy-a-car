class SubcategoriesController < ApplicationController

	def show
		@subcategory = Subcategory.find(params[:id])
		@listings = Listing.where(subcategory_id: params[:id])..order(sort_column + " " + sort_direction)	
		@category = Category.find(params[:id])
				
	end

	def find_by_category
		category = Category.find(params[:category_id])
		subcategories = category.subcategories.find_all
		render json: { subcategories: subcategories}
	end

	private 

	def sort_column
		params[:sort] ||= "created_at"
	end

	def sort_direction
		params[:direction] ||= "asc"
	end


end