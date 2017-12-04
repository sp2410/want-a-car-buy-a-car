class Coupon < ActiveRecord::Base

	belongs_to :repairshop

	mount_uploader :image, ImageUploader
	validates_uniqueness_of :title
end
