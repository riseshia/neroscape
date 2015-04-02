class EsController < ApplicationController
  before_filter :authenticate_user!

  def recent
    @reviews = Review.order("id DESC").limit(10)
  end

  def result
  	@keyword = params[:keyword]
  	@games = Game.where("name like ?", "%#{@keyword}%").order("name ASC").paginate(page: params[:page], per_page: 50)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  def item
    item_id = params[:id]

    @game = Game.find_by_id(item_id)
    @user = current_user()
    @rated = Rating.where("user_id=? AND game_id=?", @user.id, @game.id)

  end

  def user
    @user = User.find_by_id(params[:id]) if params[:id]
    @user ||= current_user()

    @reviews = Review.where("user_id = ?", @user.id).order("id DESC")
  end

  def user_stats
    @user = User.find_by_id(params[:id]) if params[:id]
    @user ||= current_user()

    @reviews = Review.where("user_id=?",@user.id)
    @review_count = @reviews.size
    @data_for_total_score = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
    @reviews.each do |review|
      scored = 0
      scored += 1 unless review.story == -1
      scored += 1 unless review.cg == -1
      scored += 1 unless review.voice == -1
      scored += 1 unless review.system == -1
      scored += 1 unless review.music == -1
      scored += 1 unless review.hscene == -1
      
      avg = review.total*2/scored
      avg = 19 if avg == 20
      @data_for_total_score[avg] += 1
    end
  end

  def rating
    item_id = params[:id]
    rate = params[:rating]

    @user = current_user()

    rating = Rating.new
    rating.user_id = @user.id
    rating.game_id = item_id
    rating.rating = rate
    rating.save!

    # send data and save local
  	redirect_to "/item?id=#{params[:id]}", alert: "평가가 저장되었습니다."
  end

  def tsumige
    @user = User.find_by_id(params[:id]) if params[:id]
    @user ||= current_user()

    @tsumiges = @user.tsumige
  end

  def add_tsumige
    @user = current_user()

    @tsumige = Tsumige.new
    @tsumige.user_id = @user.id
    @tsumige.game_id = params[:game_id]

    @tsumige.save!

    redirect_to game_path(params[:game_id])
  end

  def remove_tsumige
    @user = current_user()

    @tsumige = Tsumige.where("user_id= ? AND game_id = ?", @user.id, params[:game_id])

    if @tsumige.count == 1
      @tsumige.first.destroy
    end

    redirect_to game_path(params[:game_id])
  end
end
