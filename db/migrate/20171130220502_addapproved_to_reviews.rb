class AddapprovedToReviews < ActiveRecord::Migration
  def change
  	add_column :reviews, :approved, :boolean, :default => false
  end
end
