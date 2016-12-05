class SearchController < ApplicationController
  before_action :authenticate_user!

  def results
  	@allusers = User.all
  	if params[:search]
      @challenges = Challenge.search(params[:search]).order("score DESC")
      @users = User.search(params[:search]).order("userscore DESC")
    else
      @challenges = Challenge.all.order("created_at DESC")
      @users = User.all.order("userscore DESC")
    end
  end
end
