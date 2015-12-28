# ReviewsController
class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  respond_to :html

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = if params[:user_id]
                 Review.where(user_id: params[:user_id])
               else
                 Review
               end.paginate(page: params[:page])
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new(game_id: params[:game_id])
  end

  # GET /reviews/1/editable
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user = current_user

    @review.save
    respond_with @review
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    @review.editable?(current_user) && @review.update(review_params)
    respond_with @review
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.editable?(current_user) && @review.destroy
    respond_with @review
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def review_params
    params.require(:review).permit(:score, :content, :user_id, :game_id, :reviewed)
  end
end
