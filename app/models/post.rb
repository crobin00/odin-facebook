class Post < ApplicationRecord
  validates :author_id, presence: true
  validates :body, presence: true 

  belongs_to :author, class_name: "User"
end
