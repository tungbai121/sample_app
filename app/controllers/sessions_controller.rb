class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    authenticate user
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def authenticate user
    if user&.authenticate(params[:session][:password])
      activate_check user
    else
      flash.now[:danger] = t "invalid"
      render :new
    end
  end

  def activate_check user
    if user.activated?
      accept_access user
    else
      flash[:warning] = t "warning_activate"
      redirect_to root_url
    end
  end

  def accept_access user
    log_in user
    remember_check user
    redirect_back_or user
  end

  def remember_check user
    if Settings.session.remember == params[:session][:remember_me]
      remember user
    else
      forget user
    end
  end
end
