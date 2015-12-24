# RelGameSubgenresController
class RelGameSubgenresController < ApplicationController
  before_action :locked?
  before_action :set_rel_game_subgenre, only: :show

  # GET /rel_game_subgenres
  # GET /rel_game_subgenres.json
  def index
    @rel_game_subgenres = RelGameSubgenre.paginate(page: params[:page])
  end

  # GET /rel_game_subgenres/1
  # GET /rel_game_subgenres/1.json
  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rel_game_subgenre
    @rel_game_subgenre = RelGameSubgenre.find(params[:id])
  end
end
