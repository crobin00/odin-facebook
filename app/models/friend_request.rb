class FriendRequest < ApplicationRecord
  validates :sent_user_id, presence: true
  validates :received_user_id, presence: true

  belongs_to :sent_user, class_name: "User"
  belongs_to :received_user, class_name: "User"
end
