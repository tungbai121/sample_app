class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(show new create)
  before_action :load_user, except: %i(index new create)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.activated.page(params[:page]).per Settings.paging.size
  end

  def show
    if @user.activated?
      @microposts = @user.microposts
                         .order_by_created_at
                         .page(params[:page])
                         .per Settings.paging.size
    else
      flash[:danger] = t "unactivated"
      redirect_to root_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "check_email"
      redirect_to root_url
    else
      flash[:danger] = t "unsuccess"
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      flash[:danger] = t "update_fail"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "destroy_success"
    else
      flash[:danger] = t "destroy_fail"
    end
    redirect_to users_url
  end

  private

  def correct_user
    redirect_to root_url unless current_user? @user
  end

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
