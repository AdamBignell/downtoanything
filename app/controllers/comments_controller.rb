class CommentsController < ApplicationController
  def index
    @comments = Comment.all
  end
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.update_attribute(:user_id, current_user)

    if @comment.save
      flash[:success] = 'Your comment was successfully added!'
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:user, :body, :user_id, :submission_id)
    end
end
