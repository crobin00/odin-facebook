class Friend < ApplicationRecord
  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates_uniqueness_of :user_id, :scope => [:friend_id]
  after_destroy :destroy_inverse_relationship

  belongs_to :user
  belongs_to :friend, class_name: "User"

  def destroy_inverse_relationship
    friendships = Friend.where(friend: user)
    friendships.destroy_all
  end
end
