#encoding: utf-8
#处理消费者预定、在线报名
class BooksController < ApplicationController
  before_filter :authenticate_user!, except: [:new, :create]
  before_action :set_book, only: [:show, :edit, :update, :destroy]

  # GET /books
  # GET /books.json
  def index
    @books = Book.joins(:page).where("pages.user_id = ?", current_user.id).order("created_at DESC").page(params[:page])
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
  end

  # POST /books
  # POST /books.json
  def create
    page = Page.find(book_params[:page_id])

    phone = book_params[:phone].nil? ? '18088'+ rand(699999).to_s : book_params[:phone]
    member = Member.find_by(phone: phone)
    member ||= Member.create(
      user_id: page.user_id, 
      name: book_params[:name], 
      email: "#{phone}@qq.com", 
      phone: phone, 
      password: '000000', 
      password_confirmation: '000000',
      address: book_params[:address])
    
    @book = Book.new(book_params)
    @book.member_id = member.id
    respond_to do |format|
      if @book.save
        format.html { redirect_to get_url(@book.page), notice: '产品预定成功, 我们会尽快与您联系.' }
        format.json { render action: 'show', status: :created, location: @book }
      else
        format.html { render action: 'new' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:page_id, :name, :email, :phone, :address, :message, :is_processed, :note)
    end
end
