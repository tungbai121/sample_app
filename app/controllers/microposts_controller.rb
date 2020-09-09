class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :correct_user, only: :destroy
  before_action :attach_image, only: :create

  def create
    if @micropost.save
      flash[:success] = t ".created"
      redirect_to root_url
    else
      flash.now[:danger] = t ".create_failed"
      @feed_items = current_user.feed
                                .order_by_created_at
                                .page(params[:page])
                                .per Settings.paging.size
      render "static_pages/home"
    end
  end

  def destroy
    if @micropost.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".delete_failed"
    end
    redirect_to request.referer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit :content, :image
  end

  def correct_user
    @micropost = current_user.microposts.find_by id: params[:id]
    redirect_to root_url unless @micropost
    return if @micropost

    flash[:danger] = t ".user_invalid"
    redirect_to root_url
  end

  def attach_image
    @micropost = current_user.microposts.build micropost_params
    @micropost.image.attach params[:micropost][:image]
  end
end
