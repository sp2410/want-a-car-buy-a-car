class NewInquiryCreator
	include Sidekiq::Worker 
	sidekiq_options retry: false

	def perform(dealer_params, inquiry_params)		
		if dealer_params.include? "allleads2deals"
			(User.leads2deals.emails).each do |dealer|
				inquiry = Inquiry.new(inquiry_params.merge(:to_email => dealer))	
				inquiry.senttoall = true
				inquiry.save				
			end						
		else				
			dealer_params.each do |dealer|
				inquiry = Inquiry.new(inquiry_params.merge(:to_email => dealer))									
				inquiry.save																
			end
		end
	end
end
