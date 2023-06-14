require 'digest/md5'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i[facebook]
  
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :gender, presence: true
  before_create :create_profile_url

  enum :gender, { male: 0, female: 1 }

  has_many :posts, foreign_key: "author_id", dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, foreign_key: "author_id", dependent: :destroy
  has_many :requests, class_name: "FriendRequest", foreign_key: "sent_user_id", dependent: :destroy
  has_many :friendships, class_name: "Friend", foreign_key: "user_id", dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy

  def create_profile_url
    emailHash = Digest::MD5.hexdigest(self.email)
    self.profile_pic_url = "https://www.gravatar.com/avatar/#{emailHash}?s=56" if self.profile_pic_url.nil?
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.gender = (auth.extra.raw_info.gender == "male" || auth.extra.raw_info.gender == "female") ? auth.extra.raw_info.gender : "male"
      user.profile_pic_url = auth.info.image 
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end
end
