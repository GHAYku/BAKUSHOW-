class Public::RepostsController < ApplicationController
  before_action :set_post

  def create
    if Repost.find_by(end_user_id: current_end_user.id, post_id: @post.id)
      redirect_to request.referer, alert: '既にオモロー済みです'
    else
      @repost = Repost.create(end_user_id: current_end_user.id, post_id: @post.id)
    end
  end

  def destroy
    @repost = current_end_user.reposts.find_by(post_id: @post.id)
    if @repost.present?
      @repost.destroy
    else
      redirect_to request.referer, alert: '既にオモローを取り消し済みです'
    end
  end

  private
  def set_post
    @post = Post.find(params[:post_id])
    if @post.nil?
      redirect_to request.referer, alert: '該当の投稿が見つかりません'
    end
  end
end

