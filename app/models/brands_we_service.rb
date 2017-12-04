class BrandsWeService < ActiveRecord::Base
	belongs_to :repairshop
	validates_uniqueness_of :title
end
