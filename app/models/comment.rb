class Comment < ApplicationRecord
  validates :body, presence: true
  validates :author_id, presence: true
  validates :post_id, presence: true
  belongs_to :author, class_name: "User"
  belongs_to :post
end
