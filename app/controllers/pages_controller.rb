class PagesController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_user_and_tags, only: [:index, :show, :tag, :search]
  before_action :set_page, only: [:show, :edit, :update, :destroy]

  # GET /pages
  # GET /pages.json
  def index
    @pages = @user.pages.page(params[:page])
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
    Keystore.increment_value_for("page:#{@page.id}:view_count")
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
    @page.short_title = get_short_title(@page.title) if @page.short_title.blank?

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
    @page.short_title = get_short_title(@page.title) if @page.short_title.blank?
    respond_to do |format|
      if @page.update(page_params)
        update_tag(@page)
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
    @pages = @user.pages.search(params[:search]).page(params[:page])
  end

  def tag
    @pages = @user.pages.tagged_with(params[:tag]).page(params[:page])
    render :index
  end

  private
    def set_user_and_tags
      @user = User.find(params[:user_id])
      @user ||= current_user

      @tags = @user.pages.tag_counts_on(:tags).page(params[:page])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_params
      params.require(:page).permit(:user_id, :title, :keywords, :description, :content, :qrcode, :short_title, :properties, :amount, :price, :view_count, :fav_count, :is_processed)
    end

    def generate_qrcode(page)
      url = get_url(request.host, page)
      return if url.blank?
      qr = RQRCode::QRCode.new( url, :size => 4, :level => :h )
      png = qr.to_img # returns an instance of ChunkyPNG
      png.resize(90, 90).save(File.join(Rails.root, 'public', "qrcode_#{page.id}.png" ))
    end
end
