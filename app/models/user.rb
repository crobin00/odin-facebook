class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :first_name, :last_name, presence: true
  validates :gender, presence: true

  enum :gender, { male: 0, female: 1 }

  has_many :posts, foreign_key: "author_id"
  has_many :likes, dependent: :destroy
end
