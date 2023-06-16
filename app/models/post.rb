class Post < ApplicationRecord
  validates :author_id, presence: true
  validates :body, presence: true 

  belongs_to :author, class_name: "User"
  has_one_attached :photo do |attachable|
    attachable.variant :view, resize_to_limit: [200, 200]
  end

  has_many :likes, dependent: :destroy

  has_many :comments, dependent: :destroy
end
