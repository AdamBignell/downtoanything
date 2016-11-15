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
    @user = User.find(@submission.user_id)
    @challenge = Challenge.find(@submission.challenge_id)
  end

  # GET /submissions/new
  def new
    @submission = Submission.new
    @user = User.find(session[:user_id])
  end

  # GET /submissions/1/edit
  def edit
  end

  # POST /submissions
  # POST /submissions.json
  def create
    @submission = Submission.new(submission_params)
    @user = User.find(session[:user_id])
    @submission.update_attribute(:user, @user)
    @submission.update_attribute(:user_id, session[:user_id])

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
    # Can somebody try this on their own machine? It's failing 'sometimes' (I know this is weird) on mine
    # @user.submissions << @submission
    @challenge = Challenge.find(@submission.challenge_id)
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
      params.require(:submission).permit(:user, :score, :user_id, :challenge_id, :url)
    end
end
