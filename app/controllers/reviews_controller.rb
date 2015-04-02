class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  def index
    @reviews = Review.order("id DESC").paginate(page: params[:page], per_page: 20)
  end

  # GET /reviews/1
  def show
    @user = current_user()
  end

  # GET /reviews/new
  def new
    @review = Review.new
    @review.game_id = params[:game_id]
  end

  # GET /reviews/1/edit
  def edit
    @user = current_user()
    if @review.user_id == @user.id
    else
      redirect_to reviews_url, notice: '본인이 작성한 리뷰만 수정할 수 있습니다.'
    end
  end

  # POST /reviews
  def create
    @user = current_user()
    @review = Review.new(review_params)
    @review.user_id = @user.id

    if @review.save
      @tsumige = Tsumige.where("user_id= ? AND game_id = ?", @user.id, @review.game_id)
      @tsumige.first.destroy if @tsumige.count == 1
      redirect_to @review, notice: 'Review was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /reviews/1
  def update
    @user = current_user()
    if @review.user_id == @user.id and @review.update(review_params)
      redirect_to @review, notice: 'Review was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /reviews/1
  def destroy
    @user = current_user()
    if @review.user_id == @user.id
      @review.destroy
      redirect_to reviews_url, notice: 'Review was successfully destroyed.'
    else
      redirect_to @review, notice: '본인이 작성한 리뷰만 삭제할 수 있습니다.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def review_params
      params.require(:review).permit(:user_id, :game_id, :story, :cg, :voice, :music, :system, :hscene, :total, :has_link, :link, :comments)
    end
end