class CreateTimetables < ActiveRecord::Migration
  def change
    create_table :timetables do |t|
      t.string :day
      t.datetime :start_time
      t.datetime :end_time
    end
  end
end
