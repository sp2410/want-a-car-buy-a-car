class Changedefaultvalue < ActiveRecord::Migration
  def change
  	change_column_default :inquiries, :referredby, "WACBAC"
  end
end
