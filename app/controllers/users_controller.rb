class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def index
    authorize! :index, @user, :message => '没有权限.'
    @users = User.all
  end

  #账户设置
  def account
    @payment = Payment.new
  end

  #我的订阅
  def show
    @user = current_user || User.find(params[:id])
    @feed_pages = @user.feed.page(params[:page])
    @users = @user.followed_users.page(params[:page])
  end

  def update
    authorize! :update, @user, :message => '没有权限.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end
    
  def destroy
    authorize! :destroy, @user, :message => '没有权限.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end
end