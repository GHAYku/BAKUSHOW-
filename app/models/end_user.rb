class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
<<<<<<< HEAD
         :omniauthable, omniauth_providers: %i[facebook twitter google_oauth2]
         
  def self.from_omniauth(auth)
   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
   end
  end
  
  
=======
         :omniauthable, omniauth_providers: [:twitter, :facebook, :google_oauth2]
>>>>>>> ef8f51c3eef3fed6684adb36e566fe9b9bc6f983
end
