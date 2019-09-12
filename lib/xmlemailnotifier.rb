# using SendGrid's Ruby Library
# https://github.com/sendgrid/sendgrid-ruby
require 'sendgrid-ruby'
require 'json'

class XMLEmailNotifier

	include SendGrid

	attr_accessor :from, :to, :subject, :content

	def initialize(from, to, subject, content)
		@from = from
		@to = to
		@subject = subject
		@content = content
	end


	def personalize
		@dealers = to

		@email = Mail.new
		@email.from = Email.new(email: 'noreply@tdcdigitalmedia.com')
		@email.subject = @subject

		personalization = Personalization.new
		personalization.add_to(Email.new(email: "leads2deals.tdc@gmail.com"))
		#personalization.add_to(Email.new(email: "tech@tdcdigitalmedia.com"))

		@dealers.each do |dealer|
  			personalization.add_bcc(Email.new(email: dealer))
		end

		@email.add_personalization(personalization)
		@email.add_content(Content.new(type: 'text/plain', value: "Want A Car Buy A Car. Let us help you in finding your dream vehicle."))
		@email.add_content( Content.new(type: 'text/xml', value: @content))



		# @email.template_id = '13b8f94f-bcae-4ec6-b752-70d6cb59f932'
		@email.reply_to = Email.new(email: @from)

		p @email.to_json
		return @email
	end


	def send
		begin
			tosend = personalize

			sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
			response = sg.client.mail._('send').post(request_body: tosend.to_json)
			puts response.status_code
			puts response.body
			puts response.headers
			return true

		rescue Twilio::REST::RequestError => e
			puts e.message
			puts "Email Failure"
			return false
		end

	end

end


