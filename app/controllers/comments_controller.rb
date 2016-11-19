class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @submission = Submission.find(params[:submission_id])
    @comment = @submission.comments.create(params[:comment])
    @user = User.find(current_user.id)
    @comment = @user.comments.create(params[:comment])
    @comment.update_attribute(:user, @user.username)
    @comment.update_attribute(:user_id, current_user.id)

    respond_to do |format|
      format.html { redirect_to comment_path(@comment) }
      format.js
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:user, :body, :user_id, :submission_id)
    end
end
