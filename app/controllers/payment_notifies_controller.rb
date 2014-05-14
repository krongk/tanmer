#encoding: utf-8
## 结合PaymentsController, 保存交易日志
#  在Payments#alipay_notify 中被调用

class PaymentNotifiesController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_payment_notify, only: [:show, :edit, :update, :destroy]

  # GET /payment_notifies
  # GET /payment_notifies.json
  def index
    @payment_notifies = PaymentNotify.all
  end

  # GET /payment_notifies/1
  # GET /payment_notifies/1.json
  def show
  end

  # GET /payment_notifies/new
  def new
    @payment_notify = PaymentNotify.new
  end

  # GET /payment_notifies/1/edit
  def edit
  end

  # POST /payment_notifies
  # POST /payment_notifies.json
  def create
    @payment_notify = PaymentNotify.new(payment_notify_params)

    respond_to do |format|
      if @payment_notify.save
        format.html { redirect_to @payment_notify, notice: 'Payment notify was successfully created.' }
        format.json { render action: 'show', status: :created, location: @payment_notify }
      else
        format.html { render action: 'new' }
        format.json { render json: @payment_notify.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payment_notifies/1
  # PATCH/PUT /payment_notifies/1.json
  def update
    respond_to do |format|
      if @payment_notify.update(payment_notify_params)
        format.html { redirect_to @payment_notify, notice: 'Payment notify was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @payment_notify.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payment_notifies/1
  # DELETE /payment_notifies/1.json
  def destroy
    @payment_notify.destroy
    respond_to do |format|
      format.html { redirect_to payment_notifies_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment_notify
      @payment_notify = PaymentNotify.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_notify_params
      params.require(:payment_notify).permit(:payment_id, :payment_number, :payment_count, :state, :cate, :status)
    end
end
