class RelationshipsController < ApplicationController
  before_filter :authenticate_user!
  
  def create
    @other_user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@other_user)
    respond_to do |format|
      format.html { redirect_to @other_user }
      format.js
    end
  end

  def destroy
    @other_user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@other_user)
    respond_to do |format|
      format.html { redirect_to @other_user }
      format.js
    end
  end
end
