# CharactersController
class CharactersController < ApplicationController
  before_action :locked?
  before_action :set_character, only: :show

  # GET /characters
  # GET /characters.json
  def index
    @characters = Character.paginate(page: params[:page])
  end

  # GET /characters/1
  # GET /characters/1.json
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_character
    @character = Character.find(params[:id])
  end
end
