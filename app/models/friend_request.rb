class FriendRequest < ApplicationRecord
  validates :sent_user_id, presence: true
  validates :received_user_id, presence: true
  validates_uniqueness_of :sent_user, :scope => [:received_user]
  validate :not_friends
  validate :not_pending

  belongs_to :sent_user, class_name: "User"
  belongs_to :received_user, class_name: "User"
  
  private

  def not_friends
    errors.add(:already_friends, "can't already be friends") if sent_user.friends.include?(received_user)
  end

  def not_pending
    errors.add(:already_pending, "friend request already sent") if FriendRequest.where(sent_user: sent_user, received_user: received_user).exists?
  end

  def not_self
    errors.add(:self, "can't request yourself") if FriendRequest.where(sent_user: sent_user, received_user: received_user)
  end
end
