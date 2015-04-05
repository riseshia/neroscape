class AdminController < ApplicationController
  before_filter :admin_check, except: :no_perm
  
  def users
    @users = User.paginate(page: params[:page], per_page: 10)
  end

  def lv_up
    @user = User.find_by_id(params[:user_id])

    if @user
      @user.level = 1 if @user.level == 0
      @user.save!
    end

    redirect_to admin_users_path
  end
end
