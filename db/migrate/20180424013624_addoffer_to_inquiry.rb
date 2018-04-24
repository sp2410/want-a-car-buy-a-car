class AddofferToInquiry < ActiveRecord::Migration
  def change
  	add_column :inquiries, :offer, :string, :default => "Listed Price"
  end
end
