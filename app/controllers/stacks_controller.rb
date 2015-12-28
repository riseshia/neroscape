# StacksController
class StacksController < InheritedResources::Base
  before_action :set_stack, only: :destroy
  respond_to :html

  # GET /stacks
  # GET /stacks.json
  def index
    @stacks = if params[:user_id]
                Stack.where(user_id: params[:user_id])
              else
                Stack
              end.paginate(page: params[:page])
  end

  # POST /stacks
  # POST /stacks.json
  def create
    render status: :bad_request && return unless params[:game_id]
    @stacks = Stack.create(user: current_user, game_id: params[:game_id])
    respond_with @stacks, location: -> { game_path(params[:game_id]) }
  end

  # DELETE /stacks/1
  # DELETE /stacks/1.json
  def destroy
    @stack.editable?(current_user) && @stack.destroy
    respond_with @stack
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stack
    @stack = Stack.find(params[:id])
  end
end
