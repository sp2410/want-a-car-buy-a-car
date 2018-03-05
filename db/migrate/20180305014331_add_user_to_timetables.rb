class AddUserToTimetables < ActiveRecord::Migration
  def change
  	add_reference :timetables, :user, index: true, foreign_key: {on_delete: :cascade}
  end
end
