class LikesController < ApplicationController
  before_action :find_post 

  def create
    current_user.likes.create(post: @post) unless already_liked?
    redirect_back_or_to root_path
  end

  def destroy
    @like = @post.likes.find(params[:id])
    @like.destroy if already_liked?
    redirect_back_or_to root_path
  end

  private

  def already_liked?
    Like.where(user: current_user, post_id: params[:post_id]).exists?
  end

  def find_post
    @post = Post.find(params[:post_id])
  end
end
