class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def create
    @submission = Submission.find(params[:submission_id])
    @user = User.find(current_user)
    @comment = Comment.new(comment_params)
    @comment = @submission.comments.create(comment_params)
    @user.comments << @comment

    @comment.save

    respond_to do |format|
      format.html { redirect_to comment_path(@comment) }
      format.js {render inline: "location.reload();" }
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:user, :bodytext, :user_id, :submission_id)
    end
end
