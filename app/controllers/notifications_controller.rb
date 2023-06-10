class NotificationsController < ApplicationController
  def index
    @requests = FriendRequest.where(received_user: current_user)
  end
end
