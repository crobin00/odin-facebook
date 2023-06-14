require 'digest/md5'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :gender, presence: true
  after_create :create_profile_url

  enum :gender, { male: 0, female: 1 }

  has_many :posts, foreign_key: "author_id", dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, foreign_key: "author_id", dependent: :destroy
  has_many :requests, class_name: "FriendRequest", foreign_key: "sent_user_id", dependent: :destroy
  has_many :friendships, class_name: "Friend", foreign_key: "user_id", dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy

  def create_profile_url
    emailHash = Digest::MD5.hexdigest(self.email)
    self.profile_pic_url = "https://www.gravatar.com/avatar/#{emailHash}?s=56"
  end
end
