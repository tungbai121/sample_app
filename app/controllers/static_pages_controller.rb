class StaticPagesController < ApplicationController
  def home
    return unless logged_in?

    @micropost = current_user.microposts.build
    @feed_items = current_user.feed
                              .order_by_created_at
                              .page(params[:page])
                              .per Settings.paging.size
  end

  def help; end

  def about; end

  def contact; end
end
