class AddsenttoallToInquiry < ActiveRecord::Migration
  def change
  	add_column :inquiries, :senttoall, :boolean, :default => false
  end
end
