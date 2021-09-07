class Public::HomesController < ApplicationController
  def top
   @titles = Title.order(created_at: :desc)
  end

  def home
   @post_users = Post.where(end_user_id:[current_end_user.id, * current_end_user.following_ids]).order(created_at: :desc)
   @reposts_post_ids = Repost.where(end_user_id:[current_end_user.following_ids]).pluck(:post_id)
   @reposts = Post.where(id:@reposts_post_ids)
   @posts = @post_users + @reposts.order(created_at: :desc)
   @review = Review.new
   @repost = Repost.new
  end

  def new
   @posts = Post.order(created_at: :desc)
  end

  def popular
   @posts = Post.find(Review.group(:post_id).order('sum(rate) desc').pluck(:post_id))
  end

  def about
  end
end
