class Inquiry < ActiveRecord::Base	

	enum status: {:FRESH => 'FRESH', :ATTEMPTED => 'ATTEMPTED', :CONTACTED => 'CONTACTED', :APPOINTMENT => 'APPOINTMENT', :WORKINGDEAL => 'WORKINGDEAL', :MISSEDAPPOINTMENTFOLLOWUP => "MISSEDAPPOINTMENTFOLLOWUP", :DEALERVISITFOLLOWUP => "DEALERVISITFOLLOWUP",
		:BOUGHTHERE  => 'BOUGHTHERE', :DEADDEAL => "DEADDEAL", :DONOTCALL => "DONOTCALL", :BOUGHTELSEWHERE => "BOUGHTELSEWHERE", 
		:ONHOLD => "ONHOLD", :SPAM => "SPAM"}

	validates_presence_of :phone
	validates_presence_of :from_email	
  
  	has_many :notes, :dependent => :delete_all

  		def set_as_new_inquiry
    		self.status = :fresh
    		# return true
		end

		def set_as_contacted_inquiry
    		self.status = :contacted
    		# return true
		end

		def set_as_appointment
    		self.status = :appointment
    		# return true
		end
		def set_as_negotiation
    		self.status = :negotiation
    		# return true
		end
		def set_as_bought
    		self.status = :bought
    		# return true
		end
		def set_as_donotcall
    		self.status = :donotcall
    		# return true
		end
		def set_as_boughtelsewhere
    		self.status = :boughtelsewhere
    		# return true
		end
		def set_as_onhold
    		self.status = :onhold
    		# return true
		end

		def inquiry_notes
			notes.order('updated_at DESC')
		end

		scope :sent_to_all, -> {where('senttoall = ?', true)}


		scope :individual, -> {where('senttoall = ?', false)}
		
		scope :ALL, -> {all}
		scope :FRESH, -> {where('status = ?', "FRESH")}
		scope :CONTACTED, -> {where('status = ?', "CONTACTED")}
		scope :APPOINTMENT, -> {where('status = ?', "APPOINTMENT")}
		scope :WORKINGDEAL, -> {where('status = ?', "WORKINGDEAL")}
		scope :MISSEDAPPOINTMENTFOLLOWUP, -> {where('status = ?', "MISSEDAPPOINTMENTFOLLOWUP")}
		scope :DEALERVISITFOLLOWUP, -> {where('status = ?', "DEALERVISITFOLLOWUP")}
		scope :BOUGHTHERE, -> {where('status = ?', "BOUGHTHERE")}
		scope :DEADDEAL, -> {where('status = ?', "DEADDEAL")}
		scope :DONOTCALL, -> {where('status = ?', "DONOTCALL")}
		scope :BOUGHTELSEWHERE, -> {where('status = ?', "BOUGHTELSEWHERE")}
		scope :ONHOLD, -> {where('status = ?', "ONHOLD")}

		

end
