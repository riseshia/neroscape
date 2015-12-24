class SubgenresController < ApplicationController
  before_action :set_subgenre, only: :show

  # GET /subgenres
  # GET /subgenres.json
  def index
    @subgenres = Subgenre.paginate(page: params[:page])
  end

  # GET /subgenres/1
  # GET /subgenres/1.json
  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subgenre
    @subgenre = Subgenre.find(params[:id])
  end
end
