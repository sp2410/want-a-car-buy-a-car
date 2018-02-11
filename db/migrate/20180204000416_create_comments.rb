class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :comment_by
      t.text :note

      t.timestamps null: false
    end
  end
end
