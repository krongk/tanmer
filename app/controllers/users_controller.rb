class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def index
    authorize! :index, @user, :message => '没有权限.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    redirect_to user_pages_path(@user)
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