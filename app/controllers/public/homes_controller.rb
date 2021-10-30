class Public::HomesController < ApplicationController
  before_action :authenticate_end_user!, except: [:top]
  before_action :set_right_menu, except: [:top]

  def top
  end

  def home
    @posts = Post.where(end_user_id: [current_end_user.id, * current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(5)
  end

  def new
    @posts = Post.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(5)
  end

  def popular
    posts = Post.find(Review.group(:post_id).order('sum(rate) desc').pluck(:post_id))
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(5)
  end

  def about
  end

  def myposts
    @posts = current_end_user.posts.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(5)
  end

  def myreviews
    @reviews = current_end_user.reviews.order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
  end

  def bakushow
    @reviews = Review.where(end_user_id: [current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
  end

  def set_right_menu
    @review = Review.new
    @ranking_users = EndUser.find(Post.group(:end_user_id).joins(:reviews).order('sum(rate) desc').pluck(:end_user_id))
    @random = Post.all.sample
  end

end
