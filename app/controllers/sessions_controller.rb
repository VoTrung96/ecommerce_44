class SessionsController < ApplicationController
  before_action :find_user, only: :create

  def new
    redirect_to root_url if logged_in?
  end

  def create
    if @user && @user.authenticate(params[:session][:password])
      log_in @user
      check_remember
      redirect_back_or edit_user_path @user
    else
      flash.now[:danger] = t "flash.session_danger"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  private

  def find_user
    @user = User.find_by email: params[:session][:email].downcase
  end

  def check_remember
    if params[:session][:remember_me] == Settings.users.is_remember
      remember @user
    else
      forget @user
    end
  end
end
