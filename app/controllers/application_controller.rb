class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def redirect_after_success(msg)
    redirect_to :back, notice: msg
  end
  
  def redirect_after_failure(msg)
    redirect_to :back, alert: msg
  end
  
end
