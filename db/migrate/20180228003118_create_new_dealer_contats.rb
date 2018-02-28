class CreateNewDealerContats < ActiveRecord::Migration
  def change
    create_table :new_dealer_contacts do |t|
      t.string :dealershipname
      t.string :fullname
      t.string :email
      t.string :phone
      t.string :zip
      t.string :address
      t.string :city
      t.string :state
      t.string :website
      t.string :inventoryhost
      

      t.timestamps null: false
    end
  end
end
