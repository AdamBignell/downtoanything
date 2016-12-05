class UsersController < ApplicationController

  before_action :authenticate_user!

  # GET /users
  # GET /users.json
  def index
    if is_admin?
      @users = User.all
    else
      redirect_to '/profile'
    end
    if params[:search]
      @users = User.search(params[:search]).order("userscore DESC")
    else
      @users = User.all.order("userscore DESC")
    end
  end


  def profile
     @user = current_user
     @mysubmissions = []
     @user.submissions.each do |submission|
       if submission.user_interactions.where(:user_id => @user.id).first.interaction == "created"
         @mysubmissions << submission
       end
     end
     @challenges = Challenge.all
     @mychallenges = []
     @user.challenges.each do |challenge|
       if challenge.us_chal_interactions.where(:user_id => @user.id).first.interaction == "created"
         @mychallenges << challenge
       end
     end
  end
  # GET /users/1
  # GET /users/1.json

  def show
    if user_signed_in?
      @user = User.find(params[:id])
    @mysubmissions = []
     @user.submissions.each do |submission|
       if submission.user_interactions.where(:user_id => @user.id).first.interaction == "created"
         @mysubmissions << submission
       end
     end
     @challenges = Challenge.all
     @mychallenges = []
     @user.challenges.each do |challenge|
       if challenge.us_chal_interactions.where(:user_id => @user.id).first.interaction == "created"
         @mychallenges << challenge
       end
     end
    end
  end


  # GET /users/new

  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if user_signed_in?
      @user = User.find(params[:id])
      unless current_user == @user
        flash[:notice] = "You can only edit your own user account!"
        redirect_to users_path(current_user)
        return
      end
    end
  end

  # POST /users
  # POST /users.json
  /
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  /

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if is_admin?
      @user.destroy
      respond_to do |format|
        format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def make_admin
    if is_admin?
      @user = User.find(params[:id])
      @user.admin = true
      @user.save
      @users = User.all
    end
  end

  def demote_admin
    if is_admin?
      @user = User.find(params[:id])
      @user.admin = false
      @user.save
      @users = User.all
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :username, :userscore, :team, :admin, :image, :bio, :birthdate, :location)
    end
end
