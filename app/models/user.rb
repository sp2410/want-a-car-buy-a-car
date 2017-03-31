class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :listings, dependent: :destroy
  has_one :repairshop, dependent: :destroy

  enum role: {user: 0, dealer: 1, premium: 2, repairshop: 3}
  
  

  def set_default_role
    self.role ||= :user
  end


end
