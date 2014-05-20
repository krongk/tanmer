#encoding: utf-8
class HomeController < ApplicationController
  before_action :set_user, only: [:index, :show, :search]

  def index
    #render text: request.remote_ip and return
    @book = Book.new #联系我们
  end

  def show
    #{"controller"=>"home", "action"=>"show", "user_id"=>"2", "id"=>"6a1bb3ca98"}
    #render text: params and return 
    #set page
    if params[:id] =~ /^\d+$/i
      @page = Page.find_by(id: params[:id])
    end
    @page ||= Page.find_by(short_title: params[:id])
    not_found if params[:id] && @page.nil?

    #increment rate count
    Keystore.increment_value_for("page:#{@page.id}:view_count")
    # PV(访问量)：即Page View, 即页面浏览量或点击量，用户每次刷新即被计算一次。
    # UV(独立访客)：即Unique Visitor,访问您网站的一台电脑客户端为一个访客。00:00-24:00内相同的客户端只被计算一次。 --- 暂不做统计
    # IP(独立IP)：指独立IP数。00:00-24:00内相同IP地址只被计算一次。
    Page.increment_rate_count('pv', @page.id)
    if IpAddress.new_ip?(request.remote_ip, @page.id)
      Page.increment_rate_count('ip', @page.id)
      if params[:pr_id]
        PageRate.increment_rate_count('ip', params[:pr_id])
      end
    end
    
    if params[:pr_id]
      PageRate.increment_rate_count('pv', params[:pr_id])
    end

    #extend URL redirect
    respond_to do |format|
      if !@page.extend_url.blank? && @page.typo == 'single'
          format.html { redirect_to  @page.extend_url }
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
    if params[:search] =~ /^\s*1\d{10}\s*$/ #member phone search
      member = Member.find_by(phone: params[:search])
      if member
        redirect_to user_member_path(member.user.id, member), notice: "查询到号码为#{params[:search].gsub(/\d{4}$/, '****')}的会员信息如下..."
        return
      end
    end

    @users = User.where('typo = "seed" and name like ?', "%#{params[:search]}%") if current_user
    @users ||= []
    
    @pages = if current_user 
      current_user.pages.search(params[:search]).order("updated_at desc").page(params[:page])
    elsif @user
      @user.pages.search(params[:search]).order("updated_at desc").page(params[:page])
    else
      Page.search(params[:search]).order("updated_at desc").page(params[:page])
    end
    @pages ||= []
    
  end

  private
    def set_user
      @user = User.find_by(id: params[:user_id])
      @user ||= current_user
    end

end
