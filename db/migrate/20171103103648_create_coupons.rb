class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :image
      t.string :title

      t.timestamps null: false
    end
  end
end
