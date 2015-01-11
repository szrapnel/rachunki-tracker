class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_action :set_user_session_for_now_service
  
  def redirect_after_success(msg)
    redirect_to smart_back_path, notice: msg
  end
  
  def redirect_after_failure(msg)
    redirect_to smart_back_path, alert: msg
  end
  
  def set_user_session_for_now_service
    if user_signed_in?
      NowService::set_session(user_session)
    end
  end
  
  def smart_back_path
    if request.referer.to_s.include?('edit') || request.referer.to_s.include?(action_name)
      return root_path
    else
      return request.referer
    end
  end
  
end
