class CreateBrandsWeServices < ActiveRecord::Migration
  def change
    create_table :brands_we_services do |t|
      t.string :title
      t.references :repairshop, index: true, foreign_key: true
      t.timestamps null: false
    end
  end
end
