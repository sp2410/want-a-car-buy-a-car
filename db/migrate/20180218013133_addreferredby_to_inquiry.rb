class AddreferredbyToInquiry < ActiveRecord::Migration
  def change
  	add_column :inquiries, :referredby, :string, :default => "none"
  end
end
