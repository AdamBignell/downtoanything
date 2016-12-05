class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @team = Team.find(params[:id])
    @users = @team.users # this will find the group users
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)
    
    respond_to do |format|
      if(@team.password != @team.passwordconfirmation)
        format.html { render :new, notice: 'Password Confirmation Failed.' }
      elsif (@team.password == '' || @team.passwordconfirmation == '')
        format.html { render :new, notice: 'Password field empty' }
      else 
        if (@team.save)
          format.html { redirect_to @team, notice: 'Team was successfully created.' }
          format.json { render :show, status: :created, location: @team }
        else
          format.html { render :new }
          format.json { render json: @team.errors, status: :unprocessable_entity }
        end
      end
      @user = current_user
      if @user.team_id != nil
        @previousTeam = Team.find(@user.team_id);
        if (@previousTeam.users.count == 1)
          @previousTeam.destroy
        end
      end
      @user.team_id = @team.id
      @user.save

    end

  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def join
    @team = Team.find(params[:id])
    @user = current_user;
      if @user.team_id != nil
        @previousTeam = Team.find(@user.team_id);
        if (@previousTeam.users.count == 1)
          @previousTeam.destroy
        end
      end
      @user.team_id = @team.id
      @user.save
    @user.team_id = @team.id
    respond_to do |format|
      if(@user.save)
        format.html { redirect_to teams_url, notice: 'Added to team ' + @team.name }
      end
    end
  end

   def leave
    @team = Team.find(params[:id])
    @user = current_user;
    @user.team_id = nil
    if(@team.users.count == 1)
        @team.destroy
    end
    respond_to do |format|
      if(@user.save)
        format.html { redirect_to teams_url, notice: 'Removed from team '+ @team.name }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :description, :password, :passwordconfirmation, :points)
    end
end
