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

  enum role: {user: 0, dealer: 1, premium: 2, repairshop: 3}

  geocoded_by :full_address
  after_validation :geocode

  validates_presence_of :street_address, :city, :zipcode, :phone_number

  
  def full_address
    [city, state, zipcode].join(', ')
  end


  def set_default_role
    self.role ||= :user
  end


end

