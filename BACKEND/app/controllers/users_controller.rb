class UsersController < ApplicationController

  def index 
    users = User.all 
    render json: users
  end

  def create 
    user = User.find_or_create_by(username: strong_params[:username])
    # this gives us our current user
    render json: user
  end

  def show 
    user = User.find(params[:id])
    users_open_games = user.games.select{|game| game.status == "open"}
    users_closed_games = user.games.select{|game| game.status == "closed"}
    users_games = {open: users_open_games, closed: users_closed_games }
    
    render json: users_games
  end

  private 

  def strong_params
    params.require(:user).permit(:username)
  end

end
