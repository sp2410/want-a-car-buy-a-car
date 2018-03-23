class CreateActivityLoggers < ActiveRecord::Migration
  def change
    create_table :activity_loggers do |t|
      t.string :contact
      t.string :activity
      t.string :activity_type

      t.timestamps null: false
    end
  end
end
