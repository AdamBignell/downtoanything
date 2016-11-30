class WelcomeController < ApplicationController

  # GET /welcome
  def index
    @submissions = Submission.all
    @subs = @submissions.sort_by { |sub| sub.score}
    if not @subs.blank?
      @topsub = @subs[0]
      @challenge = Challenge.find(@topsub.challenge_id)
      @interaction = UserInteraction.where(:user_id => current_user.id, :submission_id => @topsub.id).first
    end
    @users = User.all
    @comments = Comment.all
  end
end
