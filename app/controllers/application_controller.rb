class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up)  << :name
    devise_parameter_sanitizer.for(:sign_up)  << :level
    devise_parameter_sanitizer.for(:account_update) << :name
    devise_parameter_sanitizer.for(:account_update) << :level
  end

  def admin_check
    redirect_to '/', notice: '권한이 없습니다.' if current_user().level != 999
  end

  def is_editor
    redirect_to '/', notice: '권한이 없습니다.' if current_user().level < 777
  end
end
