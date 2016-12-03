class ChallengesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_challenge, only: [:show, :edit, :update, :destroy]

  # GET /challenges
  # GET /challenges.json
  def index
    @challenges = Challenge.all
    @users = User.all
    if params[:search]
      @challenges = Challenge.search(params[:search]).order("score DESC")
    else
      @challenges = Challenge.all.order("created_at DESC")
    end
  end

  # GET /challenges/1
  # GET /challenges/1.json
  def show
    @challenge = Challenge.find(params[:id])
    @users = User.all
    @user = User.find(current_user.id)
    @cre_user = @challenge.us_chal_interactions.where(:interaction => "created").first.user
    @interaction = UsChalInteraction.where(:user_id => current_user.id, :challenge_id => @challenge.id).first
    @submissions = @challenge.submissions
  end

  # GET /challenges/new
  def new
    @challenge = Challenge.new
    @user = current_user
  end

  # GET /challenges/1/edit
  def edit
    @user = @challenge.us_chal_interactions.where(:interaction => "created").first.user
  end

  # POST /challenges
  # POST /challenges.json
  def create
    @challenge = Challenge.new(challenge_params)
    @user = User.find(current_user.id)
    @interaction = UsChalInteraction.create(:interaction => "created")
    @user.us_chal_interactions << @interaction
    @challenge.us_chal_interactions << @interaction

    respond_to do |format|
      if @challenge.save
        format.html { redirect_to @challenge, notice: 'Challenge was successfully created.' }
        format.json { render :show, status: :created, location: @challenge }
      else
        format.html { render :new }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
    @user = @challenge.us_chal_interactions.where(:interaction => "created").first.user
  end

  # PATCH/PUT /challenges/1
  # PATCH/PUT /challenges/1.json
  def update
    respond_to do |format|
      if @challenge.update(challenge_params)
        format.html { redirect_to @challenge, notice: 'Challenge was successfully updated.' }
        format.json { render :show, status: :ok, location: @challenge }
      else
        format.html { render :edit }
        format.json { render json: @challenge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /challenges/1
  # DELETE /challenges/1.json
  def destroy
    @challenge.destroy
    respond_to do |format|
      format.html { redirect_to challenges_url, notice: 'Challenge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upvote
    @challenge = Challenge.find(params[:id])
    @user = User.find(params[:user])
    @cre_user = @challenge.us_chal_interactions.where(:interaction => "created").first.user
    if params[:st] == 'none'
      @interaction = UsChalInteraction.create(:interaction => 'liked')
      @user.us_chal_interactions << @interaction
      @challenge.us_chal_interactions << @interaction
      @challenge.update_attributes(:score => @challenge.score + 1)
      @cre_user.update_attributes(:userscore => @cre_user.userscore + 1)
    else
      @interaction = @challenge.us_chal_interactions.where(:user_id => @user.id).first
      if params[:st] == 'neither'
        @interaction.update_attributes(:interaction => 'liked')
        @challenge.update_attributes(:score => @challenge.score + 1)
        @cre_user.update_attributes(:userscore => @cre_user.userscore + 1)
      elsif params[:st] == 'like'
        @interaction.update_attributes(:interaction => 'neutral')
        @challenge.update_attributes(:score => @challenge.score - 1)
        @cre_user.update_attributes(:userscore => @cre_user.userscore - 1)
      else
        @interaction.update_attributes(:interaction => 'liked')
        @challenge.update_attributes(:score => @challenge.score + 2)
        @cre_user.update_attributes(:userscore => @cre_user.userscore + 2)
      end
    end
    redirect_to(:action => 'show')
  end

  def downvote
    @challenge = Challenge.find(params[:id])
    @user = User.find(params[:user])
    @cre_user = @challenge.us_chal_interactions.where(:interaction => "created").first.user
    if params[:st] == 'none'
      @interaction = UsChalInteraction.create(:interaction => 'disliked')
      @user.us_chal_interactions << @interaction
      @challenge.us_chal_interactions << @interaction
      @challenge.update_attributes(:score => @challenge.score - 1)
      @cre_user.update_attributes(:userscore => @cre_user.userscore - 1)
    else
      @interaction = @challenge.us_chal_interactions.where(:user_id => @user.id).first
      if params[:st] == 'neither'
        @interaction.update_attributes(:interaction => 'disliked')
        @challenge.update_attributes(:score => @challenge.score - 1)
        @cre_user.update_attributes(:userscore => @cre_user.userscore - 1)
      elsif params[:st] == 'like'
        @interaction.update_attributes(:interaction => 'disliked')
        @challenge.update_attributes(:score => @challenge.score - 2)
        @cre_user.update_attributes(:userscore => @cre_user.userscore - 2)
      else
        @interaction.update_attributes(:interaction => 'neutral')
        @challenge.update_attributes(:score => @challenge.score + 1)
        @cre_user.update_attributes(:userscore => @cre_user.userscore + 1)
      end
    end
    redirect_to(:action => 'show')
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_challenge
      @challenge = Challenge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def challenge_params
      params.require(:challenge).permit(:name, :score, :description)
    end
end
