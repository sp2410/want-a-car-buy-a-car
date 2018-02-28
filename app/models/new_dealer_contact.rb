class NewDealerContact < ActiveRecord::Base
	validates_presence_of :dealershipname
	validates_presence_of :email
	validates_presence_of :phone
end
