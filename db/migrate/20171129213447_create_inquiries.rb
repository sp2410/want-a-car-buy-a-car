class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string :from_email
      t.string :to_email
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :subject
      t.string :comment

      t.timestamps null: false
    end
  end
end
