class PlayersController < ApplicationController

  def index
    load_players
    render json: @players
  end

  def show
    load_player
    render json: @player
  end

  private

  def load_players
    @players = Player.all
  end

  def load_player
    @player = Player.find(params[:id])
  end


  def player_params
    player.fetch(:player, {})
  end
end