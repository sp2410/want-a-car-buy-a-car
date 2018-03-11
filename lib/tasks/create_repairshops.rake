task :create_repairshops => :environment do
	all_repairshops = User.where(:role => 2).pluck(:id).uniq
	repairshops_users = Repairshop.pluck(:user_id).uniq
	to_create_for = all_repairshops - repairshops_users
		

	to_create_for.each do |i|
		repairshop = Repairshop.new
		repairshop.user_id = i 
		user = User.find_by_id(i)
		repairshop.title = user.name
		repairshop.city = user.city
		repairshop.state = user.state
		repairshop.zipcode = user.zipcode
		repairshop.latitude = user.latitude
		repairshop.longitude = user.longitude
		repairshop.approved = true
		repairshop.description = "Not Added Yet! If you are the owner, contact us to claim"

		begin
			if Repairshop.find_by_title(repairshop.title) == nil
				repairshop.save!
			end
		rescue
		
		end

	end		
	
end
