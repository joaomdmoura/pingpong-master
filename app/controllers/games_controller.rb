class GamesController < ApplicationController
  before_action :authenticate_user!

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
  end

  def create
    params = game_params
    params[:player] = current_user
    @game = Game.new(params)

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
