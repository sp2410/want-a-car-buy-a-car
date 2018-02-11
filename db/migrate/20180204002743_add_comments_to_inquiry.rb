class AddCommentsToInquiry < ActiveRecord::Migration
  def change
  	add_reference :comments, :inquiry, index: true, foreign_key: {on_delete: :cascade}
  end
end
