class FriendRequest < ApplicationRecord
  validates :sent_user_id, presence: true
  validates :received_user_id, presence: true
  validate :not_friends
  validate :not_pending

  belongs_to :sent_user, class_name: "User"
  belongs_to :received_user, class_name: "User"
  
  private

  def not_friends
    errors.add(:already_friends, "can't already be friends") if sent_user.friends.include?(received_user)
  end

  def not_pending
    errors.add(:already_pending, "friend request already sent") if received_user.pending_requests.include?(sent_user)
  end
end
