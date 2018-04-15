task :update_location => :environment do

	Listing.where(:user_id => 45).update_all(:city => "Clinton", :state => "NY", :latitude => "43.0484029", :longitude => "-75.3785034", :zipcode => "13323")

	Listing.where(:user_id => 51).update_all(:city => "Central Square", :state => "NY", :latitude => "43.2867356", :longitude => "-76.1460357", :zipcode => "13036")

	Listing.where(:user_id => 50).update_all(:city => "Binghamton", :state => "NY", :latitude => "42.1292854", :longitude => "-75.841775", :zipcode => "13904")

	Listing.where(:user_id => 47).update_all(:city => "Bridgeport", :state => "NY", :latitude => "43.1553457", :longitude => "-75.9693622", :zipcode => "13030")

	Listing.where(:user_id => 46).update_all(:city => "East Syracuse", :state => "NY", :latitude => "43.0653446", :longitude => "-76.0785332", :zipcode => "13057")

	Listing.where(:user_id => 12).update_all(:city => "Syracuse", :state => "NY", :latitude => "42.9893349", :longitude => "-76.2908108", :zipcode => "13204")

	Listing.where(:user_id => 13).update_all(:city => "Clay", :state => "NY", :latitude => "43.1856814", :longitude => "-76.1717547", :zipcode => "13041")

	Listing.where(:user_id => 57).update_all(:city => "Phoenix", :state => "AZ", :latitude => "33.6364503", :longitude => "-112.0118669", :zipcode => "85032")

	Listing.where(:user_id => 43).update_all(:city => "Avondale", :state => "AZ", :latitude => "33.4334649", :longitude => "-112.3278161", :zipcode => "85323")

	Listing.where(:user_id => 52).update_all(:city => "Williamson", :state => "NY", :latitude => "43.2239229", :longitude => "-77.1861277", :zipcode => "14589")

	Listing.where(:user_id => 49).update_all(:city => "Woodside", :state => "NY", :latitude => "40.7512123", :longitude => "-73.9036487", :zipcode => "11377")

	Listing.where(:user_id => 53).update_all(:city => "Westmoreland", :state => "NY", :latitude => "43.1162663", :longitude => "-75.4037358", :zipcode => "13490")

	Listing.where(:user_id => 49).update_all(:city => "Woodside", :state => "NY", :latitude => "40.7512123", :longitude => "-73.9036487", :zipcode => "11377")

	Listing.where(:user_id => 1069).update_all(:city => "Mesa", :state => "AZ", :latitude => "33.4329528", :longitude => "-111.8449346", :zipcode => "85201")

	Listing.where(:user_id => 1070).update_all(:city => "Phoenix", :state => "AZ", :latitude => "33.5636878", :longitude => "-112.0595603", :zipcode => "85020")

	Listing.where(:user_id => 1071).update_all(:city => "Phoenix", :state => "AZ", :latitude => "33.4438042", :longitude => "-112.1310986", :zipcode => "85009")

	Listing.where(:user_id => 41).update_all(:city => "Phoenix", :state => "AZ", :latitude => "33.4382789", :longitude => "-112.0178286", :zipcode => "85034")

	Listing.where(:user_id => 8).update_all(:city => "Phoenix", :state => "AZ", :latitude => "33.5083316", :longitude => "-112.0565795", :zipcode => "85014")

	Listing.where(:user_id => 42).update_all(:city => "Glendale", :state => "AZ", :latitude => "33.5349253", :longitude => "-112.1847509", :zipcode => "85301")
	
	Listing.where(:user_id => 1072).update_all(:city => "Phoenix", :state => "AZ", :latitude => "33.5636878", :longitude => "-112.0595603", :zipcode => "85020")

	Listing.where(:user_id => 1073).update_all(:city => "Prescott Valley", :state => "AZ", :latitude => "34.6062718", :longitude => "-112.3099336", :zipcode => "86314")

	Listing.where(:user_id => 1074).update_all(:city => "Mesa", :state => "AZ", :latitude => "33.4525494", :longitude => "-111.7674282", :zipcode => "85213")	

	#Listing.where(:user_id => 1073).update_all(:city => "PRESCOTT VALLEY", :state => "AZ", :latitude => "34.5550811", :longitude => "-112.4831981", :zipcode => "863148566")	

	Listing.where(:user_id => 864).update_all(:city => "GILBERT", :state => "AZ", :latitude => "33.3391759", :longitude => "-111.8417458", :zipcode => "852335019")	

	Listing.where(:user_id => 1075).update_all(:city => "Mesa", :state => "AZ", :latitude => "33.379424", :longitude => "-111.8747445", :zipcode => "85202")	

	Listing.where(:user_id => 1076).update_all(:city => "Phoenix", :state => "AZ", :latitude => "33.5636878", :longitude => "-112.0595603", :zipcode => "85020")	

	Listing.update_all(:newused => "U")
end
