class UsersController < ApplicationController
  def show
    @posts = Post.where(author: current_user).order(created_at: :desc)
    @post = Post.new
  end
end
