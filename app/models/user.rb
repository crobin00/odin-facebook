require 'digest/md5'
require 'open-uri'
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: %i[facebook]
  
  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true
  validates :gender, presence: true
  validate :acceptable_photo
  before_create :create_profile_picture
  after_create :send_welcome_email

  enum :gender, { male: 0, female: 1 }

  has_many :posts, foreign_key: "author_id", dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, foreign_key: "author_id", dependent: :destroy
  has_many :requests, class_name: "FriendRequest", foreign_key: "sent_user_id", dependent: :destroy
  has_many :friendships, class_name: "Friend", foreign_key: "user_id", dependent: :destroy
  has_many :friends, through: :friendships, dependent: :destroy
  has_one_attached :avatar, dependent: :destroy

  def create_profile_picture
    self.avatar.attach(io: File.open("app/assets/images/default_profile_picture.jpg"), filename: "default_profile_picture.jpg", content_type: "image/jpeg") unless self.avatar.attached?
  end

  def remove_friend(friend)
    self.friends.destroy(friend)
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.gender = (auth.extra.raw_info.gender == "male" || auth.extra.raw_info.gender == "female") ? auth.extra.raw_info.gender : "male"
      facebook_image_url = URI.open(auth.info.image)
      user.avatar.attach(io: facebook_image_url, filename: "facebook_image.jpg")
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
  end

  def send_welcome_email
    UserMailer.with(user: self).welcome_email.deliver_later
  end

  def acceptable_photo
    return unless avatar.attached?

    acceptable_types = ["image/jpeg", "image/png"]
    unless acceptable_types.include?(avatar.content_type)
      errors.add(:avatar, "must be a JPEG OR PNG")
    end
  end
end
