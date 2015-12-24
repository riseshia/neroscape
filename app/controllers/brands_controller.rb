# BrandsController
class BrandsController < ApplicationController
  before_action :locked?
  before_action :set_brand, only: :show

  # GET /brands
  # GET /brands.json
  def index
    @brands = Brand.paginate(page: params[:page])
  end

  # GET /brands/1
  # GET /brands/1.json
  def show
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_brand
    @brand = Brand.find(params[:id])
  end
end
