# RolesController
class RolesController < ApplicationController
  before_action :set_role, only: :show

  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.page params[:page]
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end
end
