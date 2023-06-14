class FriendsController < ApplicationController
  def show
    @user = User.find(params[:id])
    @friends = @user.friends
  end
  
  def destroy
    @friend = current_user.friends.find(params[:friend_id])
    current_user.remove_friend(@friend)
    redirect_back_or_to users_path
  end
end
