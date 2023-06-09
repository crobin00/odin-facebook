class FriendRequest < ApplicationRecord
  belongs_to :sent_user, class_name: "User"
  belongs_to :received_user, class_name: "User"
end
