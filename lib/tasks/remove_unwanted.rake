task :remove_unwanted => :environment do

	Listing.where('updated_at < ?', Time.now - 7.days).delete_all

end
