class Public::HomesController < ApplicationController
  def top
  end

  def home
   @posts = Post.where(end_user_id:[current_user.id, * current_user.follower_ids]).order(created_at: :desc)
  end

  def new
   @posts = Post.order(created_at: :desc)
  end

  def popular
  end

  def about
  end
end
