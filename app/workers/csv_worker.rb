
class CsvWorker

	include Sidekiq::Worker 
	sidekiq_options retry: false

	def perform(file)
		#call import listings class method on the file.		
		imported = Listing.import_listings(file)
		# return true	
	end
end