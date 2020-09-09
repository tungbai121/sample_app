class RelationshipsController < ApplicationController
  before_action :logged_in_user
  before_action :load_relationship, only: :destroy

  def create
    @user = User.find_by id: params[:followed_id]
    if @user
      current_user.follow @user
    else
      @error = t ".user_not_found"
    end
    respond_to :js
  end

  def destroy
    @user = @relationship.followed
    if @user
      current_user.unfollow @user
    else
      @error = t ".user_not_found"
    end
    respond_to :js
  end

  private

  def load_relationship
    @relationship = Relationship.find_by id: params[:id]
    return if @relationship

    flash[:danger] = t ".relationship_not_found"
    redirect_to root_url
  end
end
