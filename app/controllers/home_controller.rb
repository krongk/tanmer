#encoding: utf-8
class HomeController < ApplicationController
  before_action :set_user, only: [:index, :search]

  #案例中心
  def case
    @user = User.first
    @pages = Page.where(user_id: @user.id).order("updated_at desc").page(params[:page])
  end

  def search
    @pages = if current_user 
      current_user.pages.search(params[:search]).order("updated_at desc").page(params[:page])
    elsif @user
      @user.pages.search(params[:search]).order("updated_at desc").page(params[:page])
    else
      Page.search(params[:search]).order("updated_at desc").page(params[:page])
    end
  end

  private
    def set_user
      @user = User.find_by(id: params[:user_id])
      @user ||= current_user
    end

end
