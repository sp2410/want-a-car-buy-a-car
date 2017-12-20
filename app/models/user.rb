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
 

end

