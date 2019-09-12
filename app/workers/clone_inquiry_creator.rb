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
				begin
					send_email(inquiry, [dealer])
				rescue
					p "email not sent"
				end
			end
			old_inquiry.senttoall = true
			old_inquiry.save
		end
	end

	def send_email(inquiry, dealers)
		from = ((inquiry.from_email.empty?) or (inquiry.from_email.nil?)) ? "none@tdcdigitalmedia.com" : inquiry.from_email
		subject = "New Lead From Want A Car Buy A Car"

		if inquiry.to_email.present?
			user = User.find_by_email(inquiry.to_email)
			if user.leademail1.present?
				dealers << user.leademail1
			end
			if user.leademail2.present?
				dealers << user.leademail2
			end
		end


		contentPlainEmail = "<html><head><style type='text/css'>body,html,.body{background:#e8e1e1!important;}</style></head><body><container><spacer size='16'></spacer><row><columns large='8'><center><h2>New Lead From Want A Car Buy A Car</h2></center></columns></row><row><columns large='6'><left><h4>**Please reply back to the customer using contact information below. **</h4><br><p><strong>Contact:</strong></p><p>Subject: #{inquiry.subject if inquiry.subject}</p><p>First Name: #{inquiry.first_name if inquiry.first_name}</p><p>Last Name: #{inquiry.last_name if inquiry.last_name}</p><p>Email: #{inquiry.from_email if inquiry.from_email }</p><p>Telephone: #{inquiry.phone if inquiry.phone}</p><br><p>Comments: #{inquiry.comment if inquiry.comment}</p><br> </left></columns><columns large='6'><left><p>**Want even more exposure on <a href = 'http://www.wantacarbuyacar.com'>Want A Car Buy A Car</a>? Try our premium display options. Call us at +1 866-338-7870 Line 5 or email us for more info. **</p></left></columns><columns large='6'><left><p>**Check out <a href = 'http://the-dealers-choice.com/'>The Dealers Choice</a> for more programs**</p></center></left><columns large='6'><center><p>For assistance, contact us at: Phone: +1 866-338-7870 Line 5, Email:sales@tdcdigitalmedia.com</p></center></columns><columns large='6'><center><p><a href = 'http://www.wantacarbuyacar.com'>Want A Car Buy A Car</a></p></center></columns><columns large='4'><center><img class='small-float-center' width='100px' height='100px' src='https://s3-us-west-2.amazonaws.com/wacbacassetsdonttouch/wacbacassets/THEDEALERSCHOICElogosmall3.png' alt=''></center></columns></row></container><body></html>"
		contentXMLEmail = "<?xml version='1.0' encoding='UTF-8'?><?adf version='1.0'?><adf><prospect><requestdate>#{inquiry.created_at}</requestdate><vehicle interest='buy'></vehicle><customer><contact><comments>Subject: #{inquiry.subject if inquiry.subject}, Comment: #{inquiry.comment if inquiry.comment}</comments><name part='first'>#{inquiry.first_name if inquiry.first_name}</name><name part='last'>#{inquiry.last_name if inquiry.last_name}</name><email>#{inquiry.from_email if inquiry.from_email }</email><phone type='cellphone'>#{inquiry.phone if inquiry.phone}</phone></contact></customer><vendor><contact><email>#{inquiry.to_email if inquiry.to_email}</email></contact><contact><email>#{user.leademail1 if user.leademail1 }</email></contact></vendor></prospect></adf>"

		@notifier = EmailNotifier.new(from, dealers, subject, contentPlainEmail)
		@notifier.send

		@notifier2 = XMLEmailNotifier.new(from, dealers, subject, contentXMLEmail)
		@notifier2.send
	end

end



