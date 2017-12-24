class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :listings, :dependent => :destroy
  has_one :repairshop, :dependent => :destroy
  has_many :reviews, :dependent => :destroy

  enum role: {"BASIC USER": 0, "BASIC DEALER": 1, "BASIC REPAIRSHOP": 2, "SILVER DEALER": 3, "GOLD DEALER": 4, "SILVER REPAIRSHOP": 5, "DIAMOND DEALER": 6}

  geocoded_by :full_address
  after_validation :geocode

  validates_presence_of :street_address, :city, :zipcode, :phone_number

  
  def full_address
    [city, state, zipcode].join(', ')
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
    (user_role == "BASIC REPAIRSHOP" or user_role == "SILVER REPAIRSHOP" or user_role == "DIAMOND DEALER") ? true : false
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

  def user_has_repairshops
    user_can_create_repairshop
  end

  def user_has_both
    user_role = self.role 
    user_role == "DIAMOND DEALER" ? true : false    
  end

end

