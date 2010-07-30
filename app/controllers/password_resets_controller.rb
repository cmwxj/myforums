class PasswordResetsController < ApplicationController
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  def new
    render
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions!
      flash[:notice] = "重设密码的指令已经发送至你邮箱" +
        "请查阅邮箱。"
      redirect_to root_url
    else
      flash[:notice] = "没有使用该邮箱的用户。"
      render :action => 'new'
    end
  end

  def edit
    render
  end

  def update
    @user.password = params[:user][:password]
    @user.password_confirmation = params[:user][:password_confirmation]
    if @user.save
      flash[:notice] = "密码已重置成功。"
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end

  private
  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:notice] = "We're sorry, but we could not locate your account." +
        "If you are have issues try copying and pasting the URL" + 
        "from your email into your browser or restarting the " +
        "reset password process."
      redirect_to root_url
    end
  end
end
