class NotificationsController < ApplicationController
  def index
    @friend_requests = FriendRequest.where(received_user: current_user)
  end
end
