class CsvWorkerUser

	include Sidekiq::Worker 
	sidekiq_options retry: false

	def perform(file)
		#call import user class method on the file.		
		imported = Listing.import_all_users(file)
		# return true	
	end
end