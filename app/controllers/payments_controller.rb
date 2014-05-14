#encoding: utf-8
## 实现用户充值功能
#参考教程：http://chloerei.com/2013/08/01/alipay-payment-in-ruby/
#
#以下是‘担保付款’交易流程：
# users/account => 提交充值表单
# payments#create => 生成订单，并跳转到支付宝支付页面（@payment.pay_url(current_user)）
# 用户支付成功，商家到支付宝‘发货’ => payments#alipay_notify (1. 调用发货地址：@payment.send_good,  2. 改变订单状态)
# 发货成功，用户到支付宝‘确认收货’ => payments#alipay_notify 改变订单状态
class PaymentsController < ApplicationController
  before_filter :authenticate_user!, :except => [:alipay_notify]
  skip_before_filter :verify_authenticity_token, :only => [:alipay_notify]
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  # GET /payments
  # GET /payments.json
  def index
    @payments = Payment.all
  end

  # 用户支付完毕后，重定向回来的页面
  def show
    @payment = Payment.find params[:id]

    # 友好的提示当前订单的状态
    callback_params = params.except(*request.path_parameters.keys)
    if callback_params.any? && Alipay::Sign.verify?(callback_params)
      if @payment.paid? || @payment.completed?
        flash.now[:notice] = "支付成功"
      elsif @payment.pending?
        flash.now[:notice] = "订单处理中，请稍后；处理完成后，系统会发送一封通知邮件。"
      end
    end
  end

  # GET /payments/new
  def new
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
  end

  # POST /payments
  # POST /payments.json
  # 创建订单
  def create
    @payment = Payment.new(payment_params.merge(state: 'pending'))
    if @payment.save
      # 订单创建成功，将用户重定向到支付页面
      redirect_to @payment.pay_url(current_user)
    else
      render action: 'new' 
    end
  end

  # 支付宝异步消息接口
  def alipay_notify
    notify_params = params.except(*request.path_parameters.keys)
    # 先校验消息的真实性
    if Alipay::Notify.verify?(notify_params)
      # 获取交易关联的订单
      @payment = Payment.find params[:out_trade_no]

      case params[:trade_status]
      when 'WAIT_BUYER_PAY'
        # 交易开启
        @payment.update_attribute :trade_no, params[:trade_no]
        @payment.pend
      when 'TRADE_FINISHED'
        # 交易完成
        need_mail = @payment.pending?
        @payment.complete
        #SystemMailer.delay.payment_payment_success(@payment.id.to_s) if need_mail
      when 'TRADE_CLOSED'
        # 交易被关闭
        @payment.cancel
        #SystemMailer.delay.payment_cancel(@payment.id.to_s)
      when 'WAIT_SELLER_SEND_GOODS'
        # 买家完成支付
        @payment.pay
        # 虚拟物品无需发货，所以立即调用发货接口
        @payment.send_good
        #SystemMailer.delay.payment_payment_success(@payment.id.to_s)
      else
        # do nothing
      end

      @payment.payment_notifies.create!(verify: true, payment_number: "p#{@payment.id}r#{rand(30034)}", payment_count: @payment.price, state: 'income', cate: '在线充值', status: params[:trade_status])
      # 成功接收消息后，需要返回纯文本的 ‘success’，否则支付宝会定时重发消息，最多重试7次。 
      render :text => 'success'
    else
      @payment.payment_notifies.create!(verify: false, payment_number: "p#{@payment.id}r#{rand(30034)}", payment_count: @payment.price, state: 'income', cate: '在线充值', status: params[:trade_status])

      render :text => 'error'
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to @payment, notice: 'Payment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:user_id, :price, :state, :pending_at, :completed_at, :canceled_at, :paid_at, :trade_no, :note)
    end
end
