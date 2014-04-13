class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #skip CSRF on create.
  skip_before_filter :verify_authenticity_token, :only => [:create]

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  #render 404 error
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
