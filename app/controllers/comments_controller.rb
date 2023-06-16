class CommentsController < ApplicationController
  def create
    current_user.comments.create(body: params[:body], post_id: params[:post_id])
    redirect_to root_path
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    puts @comment

    if current_user.comments.include?(@comment) && @comment.update(body: params[:body])
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end
end
