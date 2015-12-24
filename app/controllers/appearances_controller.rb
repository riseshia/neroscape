# AppearancesController
class AppearancesController < ApplicationController
  before_action :locked?
  before_action :set_appearance, only: :show

  # GET /appearances
  # GET /appearances.json
  def index
    @appearances = Appearance.paginate(page: params[:page])
  end

  # GET /appearances/1
  # GET /appearances/1.json
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_appearance
    @appearance = Appearance.find(params[:id])
  end
end
