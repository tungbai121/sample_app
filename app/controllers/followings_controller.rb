class FollowingsController < ApplicationController
  before_action :load_user

  def index
    @title = t ".following"
    @users = @user.following.page(params[:page]).per Settings.paging.size
    render "users/show_follow"
  end
end
