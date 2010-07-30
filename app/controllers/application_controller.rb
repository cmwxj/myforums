# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  helper_method :current_user
  helper_method :login_required
  helper_method :is_admin?
  helper_method :logged_in?
  private  
  def current_user_session  
    return @current_user_session if defined?(@current_user_session)  
    @current_user_session = UserSession.find  
  end  
  
  def current_user  
    @current_user = current_user_session && current_user_session.record  
  end  
  
  def login_required
    unless logged_in?
      session[:original_uri] = request.request_uri
      flash[:notice] = "请先登录。"
      redirect_to login_url
    end
  end

  def logged_in?
    not current_user.nil?
  end

  def is_admin?
    current_user.username == 'admin' if current_user
  end
  
  def admin_required
    is_admin? || admin_denied
  end
  def admin_denied
    respond_to do |format|
      format.html do
        flash[:notice] = '你不是管理员，没有此操作权限。'
        redirect_to forums_path
      end
    end
  end
end
