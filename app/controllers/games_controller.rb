# GamesController
class GamesController < ApplicationController
  before_action :locked?
  before_action :set_game, only: :show

  # GET /games
  # GET /games.json
  def index
    @games = if params[:brand_id]
               Game.includes(:brand).where('brand_id = ?', params[:brand_id]).paginate(page: params[:page])
             else
               Game.includes(:brand).paginate(page: params[:page])
             end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @roles = Role.all
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.includes(:brand, :characters, :appearances, :creators, :subgenres, :categories).find(params[:id])
  end
end
