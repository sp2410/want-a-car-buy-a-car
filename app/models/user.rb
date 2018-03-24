require 'csv_uploading' 
require 'csv'
require 'active_record'
require 'activerecord-import'
require 'activerecord-import/base'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_many :listings, :dependent => :destroy
  has_one :repairshop, :dependent => :destroy
  has_many :reviews, :dependent => :destroy

  has_many :timetables, :dependent => :destroy

  extend FriendlyId
  friendly_id :name, use: :slugged

  # def to_param
  #   "#{id}-#{name}".parameterize
  # end





  enum role: {"BASIC USER": 0, "BASIC DEALER": 1, "BASIC REPAIRSHOP": 2, "SILVER DEALER": 3, "GOLD DEALER": 4, "SILVER REPAIRSHOP": 5, "DIAMOND DEALER": 6, "SALES": 7}

  geocoded_by :full_address
  after_validation :geocode

  validates_presence_of :street_address, :city, :zipcode, :phone_number

    mount_uploader :backgroundimage, ImageUploader

    mount_uploader :logoimage, ImageUploader


    scope :all_users, -> {all}
    scope :basic_users, -> {where('users.role = ?', 0)}
    scope :basic_dealers, -> {where('users.role = ?', 1)}
    scope :basic_repairshops, -> {where('users.role = ?', 2)}
    scope :silver_dealers, -> {where('users.role = ?', 3)}
    scope :silver_repairshops, -> {where('users.role = ?', 4)}
    scope :gold_dealer, -> {where('users.role = ?', 5)}
    scope :diamond_dealer, -> {where('users.role = ?', 6)}

    scope :leads2deals, -> {where('users.leads2dealscustomer = ?', true)}

    scope :emails, -> {pluck(:email)}

    scope :all_emails_for_send_all, -> {leads2deals.emails.push("allleads2deals")}

    def self.get_dealers_count
      User.where(:role => [1, 3, 4, 6]).count
    end

    # scope :leads2dealsemails, -> {leads2deals.emails}


    # scope :dealers_search_cities, -> {group('created_at, city').count}    
    # scope :dealers_search_states, -> {group('created_at, state').count}   

    def self.dealers_search_cities(users)
      return {} if users.size < 1

      final_hash = Hash.new

      users.each do |user|
        city = user.city
        if final_hash.has_key?(city)
          final_hash[city] += 1
        else
          final_hash[city] = 1
        end
      end

      return final_hash
    end

    def self.dealers_search_states(users)
      return {} if users.size < 1

      final_hash = Hash.new

      users.each do |user|
        state = user.state
        if final_hash.has_key?(state)
          final_hash[state] += 1
        else
          final_hash[state] = 1
        end
      end

      return final_hash
    end
    # scope :user_search_ratings, -> {group(:state).count}


  def self.get_ratings_for_each(users)
    return {} if users.size < 1

    final_hash = Hash.new 
    final_hash[1] = 0
    final_hash[2] = 0
    final_hash[3] = 0
    final_hash[4] = 0
    final_hash[5] = 0

    users.each do |user|      
      rating = Review.get_average_rating(user.id)
      count = final_hash[rating]
      final_hash[rating] = count+1
    end

    return final_hash

  end


  def get_dealer_rating
    Review.get_average_rating(self.id).to_s
  end


  
  def full_address
    [city, state, zipcode].join(', ')
  end

  def city_state
    [state, zipcode].join(', ')
  end

 
  def set_default_role
    self.role ||= :user
  end

  def get_net_payment
    user_role = self.role 

    if user_role == "BASIC USER"
      return "5 One time for 30 days"
    elsif user_role == "BASIC DEALER"
      return "10 one time for 30 days"
    elsif user_role == "BASIC REPAIRSHOP"
      return "5 one time for 30 days"
    elsif user_role == "SILVER DEALER"
      return "99 per month"
    elsif user_role == "SILVER REPAIRSHOP"
      return "99 per month"
    elsif user_role == "GOLD DEALER"
      return "199 per month"
    elsif user_role == "DIAMOND DEALER"
      return "299 per month"
    else
      return 0
    end     
  end

   


  def user_can_create_listing
    user_role = self.role 
    user_role == "BASIC USER" ? true : false        
  end

  def user_can_create_repairshop
    user_role = self.role 
    (user_role == "BASIC REPAIRSHOP" or user_role == "SILVER REPAIRSHOP") ? true : false
        # (user_role == "BASIC REPAIRSHOP" or user_role == "SILVER REPAIRSHOP" or user_role == "DIAMOND DEALER") ? true : false
  end

  def user_can_create_offer
    user_role = self.role 
    user_role == "DIAMOND DEALER" or user_role == "GOLD DEALER" ? true : false
  end

  def user_can_create_coupons
    user_role = self.role 
    user_role == "SILVER REPAIRSHOP" ? true : false
  end

  def user_can_create_specalizations_and_brands
    user_role = self.role 
    (user_role == "SILVER REPAIRSHOP" or user_role == "DIAMOND DEALER") ? true : false
  end

  def user_can_view_wholesale
    user_role = self.role 
    user_role == "BASIC DEALER" or user_role == "SILVER DEALER" or user_role == "DIAMOND DEALER" or user_role == "GOLD DEALER" ? true : false
  end

  def user_can_add_wholesale
    user_role = self.role 
    user_role == "DIAMOND DEALER" or user_role == "SILVER DEALER" or user_role == "GOLD DEALER" ? true : false
  end
  
  def user_has_listings
    user_role = self.role 
    user_role == "BASIC USER" or user_role == "BASIC DEALER" or user_role == "SILVER DEALER" or user_role == "DIAMOND DEALER" or user_role == "GOLD DEALER" ? true : false    
  end

  def user_is_sales_team
    user_role = self.role 
    user_role == "SALES" or user_role == 7 ?  true : false    
  end

  def user_is_diamond_dealer
    user_role = self.role 
    user_role == "DIAMOND DEALER" or user_role == 6 ?  true : false    
  end

  def user_has_repairshops
    user_can_create_repairshop
  end

  def user_has_both
    # user_role = self.role 
    # user_role == "DIAMOND DEALER" ? true : false    
    false
  end

  def number_of_listings
    Listing.where(:user_id => self.id).count
  end

  def number_of_repairshops
      Repairshop.where(:user_id => self.id).count
  end

 def self.dealer_search(params)
    if params
      dealers = User.where(:role => [1, 3, 4, 6])
        # dealers = User.all                 

      dealers2 = dealers


      if params[:radius].present?
        #sleep 0.2
        if params[:location].present?
          ids = dealers.near(params[:location].upcase,params[:radius], order: 'distance').map{|i| i.id} 
          dealers = User.where(id: ids).order("position(id::text in '#{ids.join(',')}')")
          ids.clear
        end             
      else
        #sleep 0.2        
        if params[:location].present?
          ids = dealers.near(params[:location].upcase,100, order: 'distance').map{|i| i.id} 
          dealers = User.where(id: ids).order("position(id::text in '#{ids.join(',')}')")
          ids.clear
        end 
        
        #dealers = User.where(id: dealers.near(params[:location].upcase,20, order: 'distance').map{|i| i.id}) if params[:location].present?       
      end



      # if dealers.empty?
      #   #sleep 0.2    
      #   if params[:location].present?   
      #     ids = dealers2.near(params[:location].upcase,200, order: 'distance').map{|i| i.id}
      #     dealers = User.where(id: ids).order("position(id::text in '#{ids.join(',')}')") 
      #     ids.clear
      #   end             
      # end

      dealers

    else      
      all
    end
end

end





#user import

def self.import_all_users(file) 
    start = Time.now  
    count = 0
    valid_users = Array.new
    data = {}   
    user_emails = User.all.pluck(:email)
    # last_user_id = User.last.id   
    # users = User.all.as_json
    # user_hash = Hash.new

    # users.each do |i|
    #   user_hash[i["id"]] = i
    # end

    map = {

        "DLR_TYPE" => :type,      
        "BUSINESS NAME" => :name,
        "STREET ADDRESS"  => :street_address,
        "DBA(S)" => :dba,
        "CITY"   => :city,
        "ST" => :state,
        "ZIP" => :zipcode,
        "PHONE #" => :phone_number

      }

    # p user_hash
    # p "*******************************"
    # p "*******************************"


    # p Listing.count
    # p Listing.delete_all
    # p "problem is here 1"
    CSV.foreach(file, headers: true, encoding:'iso-8859-1:utf-8') do |row|
      #Use create when you dont need customization with the listing 
      
        row.to_hash.each do |k, v|
          key = map[k]
          data[key] = v.strip
        end

        user = User.new

        if  data[:type] == "AR" 
          user.role = 2       
        else
          user.role = 1
        end 

        if data[:dba] and data[:dba] != ""
          user.name = data[:dba]
        else
          user.name = data[:name] if data[:name]
        end

        #user.name = data[:name]  if data[:name]
        user.city = data[:city] if data[:city]
        user.zipcode = data[:zipcode] if data[:zipcode] 
        user.state = data[:state] if data[:state] 
        user.phone_number = data[:phone_number] if data[:phone_number]  
        user.street_address = data[:street_address] if data[:street_address]


        
        the_email = User.email_generator

        while !(user_emails.include?(the_email))
          the_email = User.email_generator        
        end

        user.email = the_email
        user_emails << the_email

        user.password = "123abc"
        user.password_confirmation = "123abc"


        #begin
  
          valid_users << user       
          
          data.clear

        # rescue Exception => e
          
        # end
        
    end

    # p "problem is here 2"p valid_listings
    # 

      count = valid_users.size

    # begin
      # p valid_listings
      #Listing.import valid_listings, on_duplicate_key_update: { conflict_target: [:vin], columns: [:user_id, :newused, :stocknumber, :model, :year, :trim, :miles, :enginedescription,:cylinder,:fuel,:transmission,  :price, :color, :interiorcolor, :options, :description,:city, :state, :zipcode, :approved]}
      User.import valid_users, on_duplicate_key_update: [:email, :password, :password_confirmation, :name, :role, :city, :zipcode, :state]
      # }
      # p Listing.count
      # p Listing.all
    # rescue
    #   p "some issue"
    # end

    finish = Time.now
    puts diff = finish - start
    count == 0 ? false : count    
    # p self.last
end

def self.email_generator  
  sample = (2..99).to_a
  return "newuser#{sample.sample}#{sample.sample}#{sample.sample}@#{sample.sample}gmail.com"
end


