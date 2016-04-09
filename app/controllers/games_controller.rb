# GamesController
class GamesController < ApplicationController
  before_action :set_game, only: :show
  before_action :set_filter, only: :index

  # GET /games
  # GET /games.json
  def index
    @games = Game.with_filter(@filters).page params[:page]
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @roles = Role.all
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.includes(
      :brand, :characters, :appearances, :creators, :subgenres, :categories
    ).find(params[:id])
  end

  def set_filter
    @filters = {}
    @filters[:brand_id] = params[:brand_id] if params[:brand_id].present?
    @filters[:year] = params[:year] if params[:year].present?
    @filters[:month] = params[:month] if params[:month].present?
  end
end
