class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = current_user.games
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.player = current_user

    if @game.save
      redirect_to games_path, notice: 'Game was successfully created.'
    else
      render :new
    end
  end

  private

    def game_params
      params.require(:game).permit(:player_id, :opponent_id, :played_at, :player_score, :opponent_score)
    end
end
