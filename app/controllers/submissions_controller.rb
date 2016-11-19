class SubmissionsController < ApplicationController

  before_action :authenticate_user!

  before_action :set_submission, only: [:show, :edit, :update, :destroy]

  # GET /submissions
  # GET /submissions.json
  def index
    @submissions = Submission.all
    @users = User.all
    @challenges = Challenge.all
  end

  # GET /submissions/1
  # GET /submissions/1.json
  def show
    @submission = Submission.find(params[:id])
    @user = User.find(@submission.user_id).username
    @challenge = Challenge.find(@submission.challenge_id)
  end

  # GET /challenges/:challenge_id/submissions/new
  def new
    @challenge = Challenge.find(params[:challenge_id]);
    @submission = Submission.new
    @user = User.find(current_user.id)
  end

  # GET /submissions/:id/edit
  def edit
    @user = User.find(@submission.user_id)
  end

  # POST /challenges/:challenge_id/submissions
  # POST /challenges/:challenge_id/submissions.json
  def create
    @submission = Submission.new(submission_params)

    @user = User.find(current_user.id)
    @interaction = UserInteraction.create(:interaction => "created")
    @user.user_interactions << @interaction
    @submission.user_interactions << @interaction
    @submission.update_attribute(:user, @user)
    @submission.update_attribute(:user_id, current_user.id)

    respond_to do |format|
      if @submission.save
        format.html { redirect_to @submission, notice: 'Submission was successfully created.' }
        format.json { render :show, status: :created, location: @submission }
      else
        format.html { render :new }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
    @user = User.find(@submission.user_id)
    
    @challenge = Challenge.find(params[:challenge_id])
    @challenge.submissions << @submission
  end

  # PATCH/PUT /submissions/1
  # PATCH/PUT /submissions/1.json
  def update
    respond_to do |format|
      if @submission.update(submission_params)
        format.html { redirect_to @submission, notice: 'Submission was successfully updated.' }
        format.json { render :show, status: :ok, location: @submission }
      else
        format.html { render :edit }
        format.json { render json: @submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /submissions/1
  # DELETE /submissions/1.json
  def destroy
    @submission.destroy
    respond_to do |format|
      format.html { redirect_to submissions_url, notice: 'Submission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_submission
      @submission = Submission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def submission_params
      params.require(:submission).permit(:user, :score, :user_id, :challenge_id, :url, :description, :title, :embed, :thumbnail, :duration)
    end
end
