class PageRatesController < ApplicationController
  before_action :set_page_rate, only: [:show, :edit, :update, :destroy]

  # GET /page_rates
  # GET /page_rates.json
  def index
    @page_rates = PageRate.all
  end

  # GET /page_rates/1
  # GET /page_rates/1.json
  def show
    @page = @page_rate.page
    @pr_qrcode_path = get_qrcode(@page_rate)
  end

  # GET /page_rates/new
  def new
    @page_rate = PageRate.new
  end

  # GET /page_rates/1/edit
  def edit
  end

  # POST /page_rates
  # POST /page_rates.json
  def create
    page = Page.find(page_rate_params[:page_id])
    member = Member.find_by(phone: page_rate_params[:phone])
    member ||= Member.create!(user_id: page.user_id, name: page_rate_params[:name], email: "#{page_rate_params[:phone]}@qq.com", phone: page_rate_params[:phone], password: '000000', password_confirmation: '000000')
    
    unless @page_rate = PageRate.find_by(page_id: page.id, member_id: member.id)
      @page_rate = PageRate.new(page_rate_params)
      @page_rate.member_id = member.id
      @page_rate.rate_count = 1
    end

    respond_to do |format|
      if @page_rate.save
        format.html { redirect_to @page_rate, notice: t('.notice') }
        format.json { render action: 'show', status: :created, location: @page_rate }
      else
        format.html { render action: 'new' }
        format.json { render json: @page_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /page_rates/1
  # PATCH/PUT /page_rates/1.json
  def update
    respond_to do |format|
      if @page_rate.update(page_rate_params)
        format.html { redirect_to @page_rate, notice: 'Page rate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @page_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_rates/1
  # DELETE /page_rates/1.json
  def destroy
    @page_rate.destroy
    respond_to do |format|
      format.html { redirect_to page_rates_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_rate
      @page_rate = PageRate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def page_rate_params
      params.require(:page_rate).permit(:page_id, :member_id, :name, :phone)
    end

    def get_qrcode(page_rate)
      qr_dir = File.join(Rails.root, 'public', 'pr_qrcode')
      FileUtils.mkdir_p qr_dir
      png_path = File.join(qr_dir, "#{page_rate.id}.png")
      if File.exist? png_path
        #FileUtils.rm png_path
      else
        url = get_url(page_rate.page, page_rate.id)
        qr = RQRCode::QRCode.new( url, :size => 6, :level => :h )
        png = qr.to_img # returns an instance of ChunkyPNG
        png.resize(120, 120).save(png_path)
      end
      return "/pr_qrcode/#{page_rate.id}.png"
    end
end
