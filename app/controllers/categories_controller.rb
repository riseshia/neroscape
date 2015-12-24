# CategoriesController
class CategoriesController < ApplicationController
  before_action :locked?
  before_action :set_category, only: :show

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.paginate(page: params[:page])
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_category
    @category = Category.find(params[:id])
  end
end
