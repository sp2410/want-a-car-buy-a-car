class AddOwnerUserToReviews < ActiveRecord::Migration
  def change
  	add_column :reviews, :owner_id, :integer
  end
end
