class CloneInquiryCreator
	include Sidekiq::Worker 
	sidekiq_options retry: false

	def perform(inquiry_params)
		#call import listings class method on the file.		
		old_inquiry = Inquiry.find_by_id(inquiry_params)

		if !old_inquiry.senttoall			
			(User.leads2deals.emails - [old_inquiry.to_email]).each do |dealer|
				inquiry = old_inquiry.dup
				inquiry.to_email = dealer			
				inquiry.senttoall = true				
				inquiry.save
			end
			old_inquiry.senttoall = true
			old_inquiry.save
		end		
	end
end
