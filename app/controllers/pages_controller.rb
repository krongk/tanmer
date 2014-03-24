class PagesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_user_and_tags, only: [:index, :show, :tag, :search]
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  # GET /pages.json
  def index
    @pages = @user.pages.order("updated_at desc").page(params[:page])
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    Keystore.increment_value_for("page:#{@page.id}:view_count")
    
    @book = Book.new
  end

  # GET /pages/new
  def new
    @page = Page.new
  end

  # GET /pages/1/edit
  def edit
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(page_params)
    @page.user_id = current_user.id

    respond_to do |format|
      if @page.save
        update_tag(@page)
        generate_qrcode(@page)
        Keystore.increment_value_for("user:#{@page.user_id}:page_count")
        Keystore.increment_value_for("page:#{@page.id}:view_count")

        format.html { redirect_to user_page_path(current_user, @page), notice: "添加成功， <a href='/users/#{current_user.id}/pages/new'>点击这里继续添加</a>." }
        format.json { render action: 'show', status: :created, location: @page }
      else
        format.html { render action: 'new' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pages/1
  # PATCH/PUT /pages/1.json
  def update
    @page.user_id = current_user.id
    respond_to do |format|
      if @page.update(page_params)
        update_tag(@page)
        generate_qrcode(@page)

        format.html { redirect_to user_page_path(current_user, @page), notice: "更新成功， <a href='/users/#{current_user.id}/pages/new'>点击这里添加新产品</a>." }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to user_pages_url(current_user) }
      format.json { head :no_content }
    end
  end

  def search
    @pages = @user.pages.search(params[:search]).order("updated_at desc").page(params[:page])
  end

  def tag
    @pages = @user.pages.tagged_with(params[:tag]).order("updated_at desc").page(params[:page])
    render :index
  end

  private
    def set_user_and_tags
      @user = User.find_by(id: params[:user_id])
      @user ||= current_user

      @tags = @user.pages.tag_counts_on(:tags).page(params[:page])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      if params[:id] =~ /^\d+$/i
        @page = Page.find_by(id: params[:id])
      end
      @page ||= Page.find_by(short_title: params[:id])
      not_found if params[:id] && @page.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:user_id, :title, :keywords, :description, :content, :qrcode, :short_title, :properties, :amount, :price, :view_count, :fav_count, :is_processed)
    end

    def generate_qrcode(page)
      url = get_url(page)
      return if url.blank?
      qr = RQRCode::QRCode.new( url, :size => 6, :level => :h )
      png = qr.to_img # returns an instance of ChunkyPNG

      qr_dir = File.join(Rails.root, 'public', 'qrcode', current_user.id.to_s)
      FileUtils.mkdir_p qr_dir
      png_path = File.join(qr_dir, "#{page.id}.png")
      if File.exist? png_path
        FileUtils.rm png_path
      end

      png.resize(120, 120).save(png_path)

      page.qrcode = "/qrcode/#{current_user.id}/#{page.id}.png"
      page.save!
    end

    # def get_short_title(title)
    #   return if title.blank?
    #   chars = []
    #   st = Pinyin.t(title).gsub(/(-|\s+)/, '-').gsub(/[^\w-]/, '')
    #   st.to_s.squeeze('-').split('-').each do |c|
    #     chars << c[0]
    #   end
    #   st = chars.join.downcase
    #   while Page.where(short_title: st).any?
    #     st += ('a'..'z').to_a[rand(26)]
    #   end
    #   return st
    # end

    #Tag 用以下的符号隔开都可以，就是不能用空格
    def update_tag(page)
      #remove all previows
      page.tag_list.clear
      #add new 
      page.keywords.split(ApplicationHelper::SPECIAL_SYMBO_REG).each do |tag|
        next if ApplicationHelper::SPECIAL_SYMBO_REG.match tag
        page.tag_list.add(tag)
        page.save!
      end
      return true
    end
end
