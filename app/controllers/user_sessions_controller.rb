class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "登录成功。"
      uri = session[:original_uri] || root_url
      session[:original_uri] = nil
      redirect_to uri
    else
      render :action => 'new'
    end
    
  end
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "成功注销登陆。"
    redirect_to root_url
  end

end
