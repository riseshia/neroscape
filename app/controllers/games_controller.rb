class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_filter :is_editor, except: [:show, :index]

  # GET /games
  def index
    @games = Game.order("id DESC").paginate(page: params[:page], per_page: 20)
  end

  # GET /games/1
  def show
    @user = current_user()

    @my_review = Review.where("user_id = ? AND game_id = ?", @user.id, @game.id)
    @tsumige = Tsumige.where("user_id= ? AND game_id = ?", @user.id, @game.id)
    
    @cg = Join.where("game_id = ? and role = ?", @game.id, 1)
    @story = Join.where("game_id = ? and role = ?", @game.id, 2)
    @music = Join.where("game_id = ? and role = ?", @game.id, 3)
    @char = Join.where("game_id = ? and role = ?", @game.id, 4)
    @voice = Join.where("game_id = ? and role = ?", @game.id, 5)
    @sing = Join.where("game_id = ? and role = ?", @game.id, 6)
    @etc = Join.where("game_id = ? and role = ?", @game.id, 7)
  end

  # GET /games/new
  def new
    @game = Game.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  def create
    @game = Game.new(game_params)
    @game.id = params["game"]["id"]

    if @game.save
      redirect_to @game, notice: 'Game was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      redirect_to @game, notice: 'Game was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
    redirect_to games_url, notice: 'Game was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = Game.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def game_params
      params.require(:game).permit(:id, :name, :furigana, :sellday, :brand_id)
    end
end
