task :remove_unwanted => :environment do

	Listing.where(:user_id => 1073).each do |listing|
		listing.description = listing.description.gsub("Â", "")
		listing.save
	end

end
