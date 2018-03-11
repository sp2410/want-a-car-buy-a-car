task :create_repairshops => :environment do
	all_repairshops = User.where(:role => 2).pluck(:id).uniq
	repairshops_users = Repairshop.pluck(:user_id).uniq
	to_create_for = all_repairshops - repairshops_users
		#to_create_for =  [58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129,130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161,162, 163, 164, 165, 166, 167, 168, 169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193,194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222]

	to_create_for.each do |i|
		epairshop = Repairshop.new
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
