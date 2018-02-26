class SendEmail
	include Sidekiq::Worker 
	sidekiq_options retry: false
	

	def perform(subject, message, user)
		from = 'sales@tdcdigitalmedia.com'          
	    content = "<html><head><style type='text/css'>body,html,.body{background:#D3D3D3!important;}</style></head><body><container><spacer size='16'></spacer><row><columns large='8'><center><h1>Want A Car Buy A Car</h1></center></columns></row><row><columns large='6'><center><h4>Hi! Its Want A Car Buy A Car Team!</h4><br><p>#{message}</p><br><p>Follow: http://www.wantacarbuyacar.com to explore more</p><center></columns><columns large='6'><br><p>Phone: +1 866-338-7870 Line 5</p><br><p>Email:sales@tdcdigitalmedia.com</p></columns><columns large='4'><img class='small-float-center' width='100px' height='100px' src='https://s3-us-west-2.amazonaws.com/wacbacassetsdonttouch/wacbacassets/THEDEALERSCHOICElogosmall3.png' alt='Want A Car Buy A Car'></columns></row><row></row></container><body></html>"
	    notifier = EmailNotifier.new(from, user, subject, content)
	    notifier.send		
	end
end
