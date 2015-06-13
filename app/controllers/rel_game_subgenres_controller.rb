class RelGameSubgenresController < ApplicationController
  before_action :set_rel_game_subgenre, only: [:show, :edit, :update, :destroy]

  # GET /rel_game_subgenres
  # GET /rel_game_subgenres.json
  def index
    @rel_game_subgenres = RelGameSubgenre.all
  end

  # GET /rel_game_subgenres/1
  # GET /rel_game_subgenres/1.json
  def show
  end

  # GET /rel_game_subgenres/new
  def new
    @rel_game_subgenre = RelGameSubgenre.new
  end

  # GET /rel_game_subgenres/1/edit
  def edit
  end

  # POST /rel_game_subgenres
  # POST /rel_game_subgenres.json
  def create
    @rel_game_subgenre = RelGameSubgenre.new(rel_game_subgenre_params)

    respond_to do |format|
      if @rel_game_subgenre.save
        format.html { redirect_to @rel_game_subgenre, notice: 'Rel game subgenre was successfully created.' }
        format.json { render :show, status: :created, location: @rel_game_subgenre }
      else
        format.html { render :new }
        format.json { render json: @rel_game_subgenre.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rel_game_subgenres/1
  # PATCH/PUT /rel_game_subgenres/1.json
  def update
    respond_to do |format|
      if @rel_game_subgenre.update(rel_game_subgenre_params)
        format.html { redirect_to @rel_game_subgenre, notice: 'Rel game subgenre was successfully updated.' }
        format.json { render :show, status: :ok, location: @rel_game_subgenre }
      else
        format.html { render :edit }
        format.json { render json: @rel_game_subgenre.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rel_game_subgenres/1
  # DELETE /rel_game_subgenres/1.json
  def destroy
    @rel_game_subgenre.destroy
    respond_to do |format|
      format.html { redirect_to rel_game_subgenres_url, notice: 'Rel game subgenre was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rel_game_subgenre
      @rel_game_subgenre = RelGameSubgenre.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rel_game_subgenre_params
      params.require(:rel_game_subgenre).permit(:game_id, :subgenre_id)
    end
end
