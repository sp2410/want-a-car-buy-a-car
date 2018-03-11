class CsvWorkerRepairshop

	include Sidekiq::Worker 
	sidekiq_options retry: false

	def perform
		#call import user class method on the file.		
		imported = Listing.create_repair_shops
		# return true	
	end
end