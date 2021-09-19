class EndUser < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(facebook twitter google_oauth2)

  def self.from_omniauth(auth)
  user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
  user.attributes = {
    email: auth.info.email,
    password: Devise.friendly_token[0, 20],
    name: auth.info.name,
    image: auth.info.image
  }
  user.save if user.changed?
  user
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "ゲスト"
    end
  end

  def active_for_authentication?
    super && (is_active == true)
  end

  attachment :image

  has_many :reviews, dependent: :destroy
  has_many :titles, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followed

  validates :name, presence: true, length: { maximum: 12 }
  validates :email, presence: true

  def follow(end_user_id)
    relationships.create(followed_id: end_user_id)
  end

  def unfollow(end_user_id)
    relationships.find_by(followed_id: end_user_id).destroy
  end

  def following?(end_user)
    followings.include?(end_user)
  end
end
