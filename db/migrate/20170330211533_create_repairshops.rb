class CreateRepairshops < ActiveRecord::Migration
  def change
    create_table :repairshops do |t|
      t.string :title
      t.text :description
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :phone

      t.timestamps null: false
    end
  end
end
