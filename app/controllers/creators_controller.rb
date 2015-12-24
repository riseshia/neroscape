# CreatorsController
class CreatorsController < ApplicationController
  before_action :set_creator, only: :show

  # GET /creators
  # GET /creators.json
  def index
    @creators = Creator.paginate(page: params[:page])
  end

  # GET /creators/1
  # GET /creators/1.json
  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_creator
    @creator = Creator.find(params[:id])
  end
end
