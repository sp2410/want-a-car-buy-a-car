class BrandsWeService < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
	belongs_to :repairshop
	validates_uniqueness_of :title
end
