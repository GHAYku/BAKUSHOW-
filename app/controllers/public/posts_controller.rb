class Public::PostsController < ApplicationController

  def index
   case params[:order]
   when "home"
    @posts = Post.where(end_user_id:[current_end_user.id, * current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(15)
    @review = Review.new
   when "new"
    @posts = Post.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(15)
    @review = Review.new
   when "popular"
    posts = Post.find(Review.group(:post_id).order('sum(rate) desc').pluck(:post_id))
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(15)
   when "myposts"
    @posts = current_end_user.posts.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(15)
    @review = Review.new
   when "reviews"
    @reviews = Review.where(end_user_id:[current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(15)
    @review = Review.new
   when "myreviews"
    @reviews = current_end_user.reviews.order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(15)
    @review = Review.new
   end
  end

  def title_posts_index
   case params[:order]
   when "home"
    @posts = Post.where(end_user_id:[current_end_user.id, * current_end_user.follower_ids]).order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(15)
    @review = Review.new
   when "new"
    @posts = Post.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(15)
    @review = Review.new
   when "popular"
    posts = Post.find(Review.group(:post_id).order('sum(rate) desc').pluck(:post_id))
    @posts = Kaminari.paginate_array(posts).page(params[:page]).per(15)
   when "myposts"
    @posts = current_end_user.posts.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(15)
    @review = Review.new
   when "reviews"
    @reviews = Review.where(end_user_id:[current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(15)
    @review = Review.new
   end
  end

  def reviews_index
   case params[:order]
   when "reviews"
    @reviews = Review.where(end_user_id:[current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(15)
    @review = Review.new
   when "myreviews"
    @reviews = current_end_user.reviews.order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(15)
    @review = Review.new
   end
  end

  def title_reviews_index
   case params[:order]
   when "reviews"
    @reviews = Review.where(end_user_id:[current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(15)
    @review = Review.new
   when "myreviews"
    @reviews = current_end_user.reviews.order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(15)
    @review = Review.new
   end
  end

  def edit
   @post = current_end_user.posts.find(params[:id])
  end

  def new
   @post = Post.new
  end

  def show
   @post = Post.find(params[:id])
   @comments = @post.comments.page(params[:page]).eager_load(:end_user).per(15)
   @comment = Comment.new
   @review = Review.new
  end

  def create
   @post = Post.new(post_params)
   @post.end_user_id = current_end_user.id
   if @post.save
     flash[:notice] = "投稿しました！"
     redirect_to request.referer
   else
     render :new
   end
  end

  def update
   @post = current_end_user.posts.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "この投稿内容を編集しました"
      redirect_to public_posts_path
    else
      render :edit
    end
  end

  def destroy
   @post = current_end_user.posts.find(params[:id])
   if @post.destroy
     flash[:notice]="この投稿を削除しました"
     redirect_to public_posts_path
   end
  end

  private
  def post_params
   params.require(:post).permit(:title_id, :genre_id, :body, :image)
  end
end