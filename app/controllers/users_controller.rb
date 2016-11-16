class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :confirm_logged_in, :except => [:new, :create]

  # GET /users
  # GET /users.json
  def index
<<<<<<< HEAD
    @users = User.all
    # @user = User.find(session[:id])
    # if ! @user.admin
    #   redirect_to({:controller => "access", :action => "index"})
    # end
=======
    if is_admin
      @users = User.all
    else
      return render :nothing => true, :status => :ok
    end

    if params[:search]
      @users = User.search(params[:search]).order("points DESC")
    else
      @users = User.all.order("points DESC")
    end
>>>>>>> 0f25edf33fbf01a1699db52d8d7092c31ba3b41c
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    # For whatever reason this line doesn't work
    @mysubmissions = @user.submissions
    @challenges = Challenge.all
    @mychallenges = @user.challenges
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
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

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
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
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def make_admin
    @user = User.find(params[:id])
    @user.admin = true
    @user.save
    redirect_to(:action => "show", :id => @user.id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :username, :points, :team, :admin)
    end
end
