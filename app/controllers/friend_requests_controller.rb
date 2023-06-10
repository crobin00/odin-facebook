class FriendRequestsController < ApplicationController
  def create
    friend = User.find(params[:friend_id])
    @request = current_user.requests.create(received_user: friend)
    redirect_to users_path
  end

  def update
    request = FriendRequest.find(params[:id])
    friend = User.find(params[:friend_id])
    current_user.friendships.create(friend: friend)
    friend.friendships.create(friend: current_user)
    request.destroy
    redirect_to users_path
  end
  
  def destroy
  end
end
