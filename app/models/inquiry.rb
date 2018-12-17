class Inquiry < ActiveRecord::Base	

	enum status: {:Fresh => 'Fresh', :Attempted => 'Attempted', :Contacted => 'Contacted', :Appointment => 'Appointment', 
		:Working_Deal => 'Working_Deal', :Missed_Appointment_Followup => "Missed_Appointment_Followup", 
		:Dealer_Visit_Followup => "Dealer_Visit_Followup", :Bought_Here  => 'Bought_Here', :Dead_Deal => "Dead_Deal", 
		:Do_Not_Call => "Do_Not_Call", :Bought_Else_Where => "Bought_Else_Where", :On_Hold => "On_Hold", :Spam => "Spam"}

	validates_presence_of :phone
	validates_presence_of :first_name
  
  	has_many :notes, :dependent => :delete_all

  		def set_as_new_inquiry
    		self.status = :Fresh
    		# return true
		end

		def set_as_contacted_inquiry
    		self.status = :Contacted
    		# return true
		end

		def set_as_appointment
    		self.status = :Appointment
    		# return true
		end
		def set_as_negotiation
    		self.status = :negotiation
    		# return true
		end
		def set_as_bought
    		self.status = :Bought_Here
    		# return true
		end
		def set_as_donotcall
    		self.status = :Do_Not_Call
    		# return true
		end
		def set_as_boughtelsewhere
    		self.status = :Bought_Else_Where
    		# return true
		end
		def set_as_onhold
    		self.status = :On_Hold
    		# return true
		end

		def inquiry_notes
			notes.order('updated_at DESC')
		end

		scope :sent_to_all, -> {where('senttoall = ?', true)}


		scope :individual, -> {where('senttoall = ?', false)}
		
		scope :ALL, -> {all}
		scope :FRESH, -> {where('status = ?', "Fresh")}
		scope :CONTACTED, -> {where('status = ?', "Contacted")}
		scope :APPOINTMENT, -> {where('status = ?', "Appointment")}
		scope :WORKINGDEAL, -> {where('status = ?', "Working_Deal")}
		scope :MISSEDAPPOINTMENTFOLLOWUP, -> {where('status = ?', "Missed_Appointment_Followup")}
		scope :DEALERVISITFOLLOWUP, -> {where('status = ?', "Dealer_Visit_Followup")}
		scope :BOUGHTHERE, -> {where('status = ?', "Bought_Here")}
		scope :DEADDEAL, -> {where('status = ?', "Dead_Deal")}
		scope :DONOTCALL, -> {where('status = ?', "Do_Not_Call")}
		scope :BOUGHTELSEWHERE, -> {where('status = ?', "Bought_Else_Where")}
		scope :ONHOLD, -> {where('status = ?', "On_Hold")}

		

end
