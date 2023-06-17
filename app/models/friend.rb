class Friend < ApplicationRecord
  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates_uniqueness_of :user_id, :scope => [:friend_id]
  after_destroy :destroy_inverse_relationship
  after_create :destroy_friend_request

  belongs_to :user
  belongs_to :friend, class_name: "User"

  def destroy_friend_request
    request1 = FriendRequest.where(sent_user: user, received_user: friend)
    request2 = FriendRequest.where(sent_user: friend, received_user: user)
    request1.destroy_all if request1.exists?
    request2.destroy_all if request2.exists?
  end

  def destroy_inverse_relationship
    friendship = Friend.find_by(user: friend, friend: user)
    friendship.destroy if friendship
  end
end
