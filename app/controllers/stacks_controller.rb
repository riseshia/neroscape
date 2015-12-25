# StacksController
class StacksController < InheritedResources::Base
  before_action :set_stack, only: :destroy

  # GET /stacks
  # GET /stacks.json
  def index
    @stacks = Stack.paginate(page: params[:page])
  end

  # DELETE /stacks/1
  # DELETE /stacks/1.json
  def destroy
    respond_to do |format|
      if @stack.editable? current_user
        @stack.destroy
        format.html { redirect_to stacks_url, notice: 'Stack was successfully destroyed.' }
        format.json { head :no_content }
      else
        format.html { redirect_to stacks_url, notice: 'Stack can not be destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_stack
    @stack = Stack.find(params[:id])
  end
end
