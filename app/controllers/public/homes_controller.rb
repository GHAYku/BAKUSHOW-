class Public::HomesController < ApplicationController
  def top
   @titles = Title.order(created_at: :desc)
  end

  def home
   @posts = Post.where(end_user_id:[current_end_user.id, * current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).per(15)
   @review = Review.new
  end

  def new
   @posts = Post.order(created_at: :desc).page(params[:page]).per(15)
  end

  def popular
   posts = Post.find(Review.group(:post_id).order('sum(rate) desc').pluck(:post_id))
   @posts = Kaminari.paginate_array(posts).page(params[:page]).per(15)
  end

  def about
  end

  def myposts
   @posts = current_end_user.posts.order(created_at: :desc).page(params[:page]).per(15)
   @review = Review.new
  end

  def myreviews
   @reviews = current_end_user.reviews.order(created_at: :desc).page(params[:page]).per(15)
   @review = Review.new
  end

  def bakushow
   @reviews = Review.where(end_user_id:[current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).per(15)
   @review = Review.new
   case  params[:order]
   when "other_user_reviews"
    @end_user = EndUser.find(params[:id])
    @reviews = @end_user.reviews.order(created_at: :desc).page(params[:page]).per(15)
    @review = Review.new
   end
  end
end