class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def admin?
    redirect_to '/', notice: '권한이 없습니다.' unless current_user.try(:admin?)
  end

  def locked?
    redirect_to home_locked_path, notice: '등업대기중입니다.' unless current_user.try(:unlocked?)
  end
end