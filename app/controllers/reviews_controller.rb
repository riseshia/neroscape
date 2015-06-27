class ReviewsController < ApplicationController
  before_action :locked?
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
    reviewed = (params[:reviewed] == "false" ? 0 : 1) || 1
    @reviews = (params[:user_id] ? current_user.reviews.where('reviewed = :reviewed', reviewed: reviewed).paginate(:page => params[:page]) : Review.where('reviewed = 1').paginate(:page => params[:page]))
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new(game_id: params[:game_id])
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.reviewed = 1

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.editable? && @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { redirect_to @review, notice: 'Review can not be edited.' }
        format.json { head :no_content }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    respond_to do |format|
      if @review.editable?
        @review.destroy
        format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to reviews_url, notice: 'Review can not be destroyed.' }
        format.json { head :no_content }
      end
    end
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
