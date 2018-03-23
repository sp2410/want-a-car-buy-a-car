class NewLogCreator
	include Sidekiq::Worker 
	sidekiq_options retry: false

	def perform(new_log_params)
		#call import listings class method on the file.	
		#begin	
			#@loggr = ActivityLogger.new(new_log_params)
			#@loggr.save
		#rescue
			
		#end
	end
end
