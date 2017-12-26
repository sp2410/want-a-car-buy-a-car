class AddAppealToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :appeal, :boolean, :default => false
  end
end
