class AddNotesandStageToInquiry < ActiveRecord::Migration
  def change  	  	
  	add_column :inquiries, :status, :string, :default => "FRESH"
  end
end
