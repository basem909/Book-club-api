class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  before_create :generate_authentication_token

  validates :name, presence: true, length: { in: 6..128 }
  validates :password, presence: true
  validates :email, presence: true

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end
end
