class AddLeadEmails < ActiveRecord::Migration
  def change
  	add_column :users, :leademail1, :string
  	add_column :users, :leademail2, :string
  end
end
