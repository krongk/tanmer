#encoding: utf-8
#保存会员信息
#会员的定义： 预定产品的、参加有奖转发的都自动转为会员

class MembersController < ApplicationController
  before_filter :authenticate_user!, except: [:show]
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def index
    @members = current_user.members.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:user_id, :name, :email, :phone, :address, :message)
    end

end
