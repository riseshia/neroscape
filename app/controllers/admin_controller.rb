class AdminController < ApplicationController
  before_filter :admin_check
  
  def users
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def lv_up
    @user = User.find_by_id(params[:user_id])

    if @user
      @user.level = 1 unless @user.level
      @user.save!
    end

    redirect_to admin_users_path
  end
end
