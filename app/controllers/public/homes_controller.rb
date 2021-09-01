class Public::HomesController < ApplicationController
  def top
  end

  def home
   @posts = Post.where(end_user_id:[current_end_user.id, * current_end_user.follower_ids]).order(created_at: :desc)
  end

  def new
   @posts = Post.order(created_at: :desc)
  end

  def popular
   @posts = Post.find(Review.group(:post_id).order('count(rate) desc').limit(3).pluck(:post_id))
  end

  def about
  end
end
