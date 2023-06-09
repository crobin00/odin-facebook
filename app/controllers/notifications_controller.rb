class NotificationsController < ApplicationController
  def index
    @pending_requests = current_user.pending_requests
  end
end
