class ChangeOptionsToText < ActiveRecord::Migration
  def change
  	change_column :listings, :options, :text
  end
end
