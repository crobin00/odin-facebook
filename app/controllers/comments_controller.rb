class CommentsController < ApplicationController
  def create
    current_user.comments.create(body: params[:body], post_id: params[:post_id])
    redirect_to root_path
  end
end
