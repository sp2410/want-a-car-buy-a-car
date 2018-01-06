class Addexpirationdatetolistings < ActiveRecord::Migration
  def change
  	add_column :listings, :expiration_date, :datetime, :default => DateTime.now + 200.year
  end
end
