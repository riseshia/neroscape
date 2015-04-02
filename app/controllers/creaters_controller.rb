class CreatersController < ApplicationController
  before_action :set_creater, only: [:show, :edit, :update, :destroy]
  before_filter :is_editor, only: [:new, :create, :edit, :update]
  before_filter :admin_check, only: :destroy

  # GET /creaters
  def index
    @creaters = Creater.order("id ASC").paginate(page: params[:page], per_page: 50)
  end

  # GET /creaters/1
  def show
  end

  # GET /creaters/new
  def new
    @creater = Creater.new
  end

  # GET /creaters/1/edit
  def edit
  end

  # POST /creaters
  def create
    @creater = Creater.new(creater_params)

    if @creater.save
      redirect_to @creater, notice: 'Creater was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /creaters/1
  def update
    if @creater.update(creater_params)
      redirect_to @creater, notice: 'Creater was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /creaters/1
  def destroy
    @creater.destroy
    redirect_to creaters_url, notice: 'Creater was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_creater
      @creater = Creater.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def creater_params
      params.require(:creater).permit(:name, :furigana)
    end
end
