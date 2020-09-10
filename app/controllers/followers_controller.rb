class FollowersController < ApplicationController
  before_action :load_user

  def index
    @title = t ".followers"
    @users = @user.followers.page(params[:page]).per Settings.paging.size
    render "users/show_follow"
  end
end
