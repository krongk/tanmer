#encoding: utf-8
class HomeController < ApplicationController
  before_action :set_user, only: [:index, :search]

  def index
    @book = Book.new #联系我们
  end

  def show
    if params[:id] =~ /^\d+$/i
      @page = Page.find_by(id: params[:id])
    end
    @page ||= Page.find_by(short_title: params[:id])
    not_found if params[:id] && @page.nil?

    Keystore.increment_value_for("page:#{@page.id}:view_count")
    
    @book = Book.new
    respond_to do |format|
      unless @page.extend_url.blank?
       
        format.html { redirect_to  @page.extend_url }
        format.json { render action: 'show', status: :created, location: @page }
      else
        format.html { render action: 'show' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

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
