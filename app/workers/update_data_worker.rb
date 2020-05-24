require 'update_data'

class UpdateDataWorker < ActiveJob::Base
  queue_as :default
  def perform
    importer = UpdateData.new
    importer.read_from_file
    importer.update_listing_from_array
    importer.update_location
	end
end