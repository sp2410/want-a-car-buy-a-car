require 'twilio-ruby'

class Twilionotifier

	attr_accessor :loosers, :finalwinner

	def initialize
		begin	
			@client = Twilio::REST::Client.new(
				ENV['TWILIO_ACCOUNT_SID'],
				ENV['TWILIO_AUTH_TOKEN']
			)
		rescue Twilio::REST::RequestError => e
   			puts e.message
		end			
	end

	def notifybidding(loosers, product_details)
		loosers.each do |looser|
			begin	

				@client.account.messages.create(
				from: ENV['TWILIO_PHONE_NUMBER'],
				to: looser.to_s,
				body: "TDCAuctionService: Sorry! You were outbid on #{product_details[1].to_s}: Follow Link and Bid To Win! http://www.tdcautoauction.com/products/#{product_details[0].to_s}"
			)

			rescue Twilio::REST::RequestError => e
   				puts e.message
			end
		end
	end


	def notify_through_text(send_to, message)

			begin	
				@client.account.messages.create(
				from: ENV['TWILIO_PHONE_NUMBER'],
				to: send_to.to_s,
				body: "#{message}"
				
				# return true
			)

			rescue Twilio::REST::RequestError => e
   				puts e.message
			end
	end
	

	# def notifyfinalwinner()
	# 	@client.messages.create(
	# 		from: ENV['TWILIO_PHONE_NUMBER'],
	# 		to: "+13157515747",
	# 		body: "Hello! Is there anybody in there!"
	# 	)		
	# end

end


