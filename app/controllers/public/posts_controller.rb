class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :set_right_menu, except: [:update,:destroy,:create]

  def set_right_menu
    @review = Review.new
    @ranking_users = EndUser.find(Post.group(:end_user_id).joins(:reviews).order('sum(rate) desc').pluck(:end_user_id))
    @random = Post.all.sample
  end

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(5)
    case params[:order]
    when "home"
      @url = "home"
      @posts = Post.where(end_user_id: [current_end_user.id, * current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(5)
    when "new"
      @url = "new"
      @posts = Post.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(5)
    when "popular"
      @url = "popular"
      posts = Post.find(Review.group(:post_id).order('sum(rate) desc').pluck(:post_id))
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(5)
    when "myposts"
      @url = "myposts"
      @posts = current_end_user.posts.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(5)
    end
  end

  def title_posts_index
    @posts = Post.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(5)
    case params[:order]
    when "home"
      @url = "home"
      @posts = Post.where(end_user_id: [current_end_user.id, * current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(5)
    when "new"
      @url = "new"
      @posts = Post.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(5)
    when "popular"
      @url = "popular"
      posts = Post.find(Review.group(:post_id).order('sum(rate) desc').pluck(:post_id))
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(5)
    when "myposts"
      @url = "myposts"
      @posts = current_end_user.posts.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(5)
    end
  end

  def reviews_index
    @reviews = Review.order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
    case params[:order]
    when "reviews"
      @reviews = Review.where(end_user_id: [current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
    when "myreviews"
      @reviews = current_end_user.reviews.order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
    end
  end

  def title_reviews_index
    @reviews = Review.order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
    case params[:order]
    when "reviews"
      @reviews = Review.where(end_user_id: [current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
    when "myreviews"
      @reviews = current_end_user.reviews.order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
    end
  end

  def edit
    @post = Post.find(params[:id])
    @title = @post.title
    if @post.end_user.id != current_end_user.id
      redirect_to public_homes_home_path
    end
  end

  def new
    @post = Post.new
  end

  def show
    @post = Post.find(params[:id])
    @title = @post.title
    @comments = @post.comments.page(params[:page]).eager_load(:end_user).per(5)
    @comment = Comment.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
      flash[:notice] = "??????????????????"
      redirect_to public_homes_home_path
    else
      flash[:danger] = "???????????????????????????????????????????????????????????????????????????????????????????????????????????????60?????????????????????"
      redirect_to request.referer
    end
  end

  def update
    @post = current_end_user.posts.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "?????????????????????????????????"
      redirect_to public_homes_home_path
    else
      flash[:danger] = "??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????60?????????????????????"
      redirect_to request.referer
    end
  end

  def destroy
    @post = current_end_user.posts.find(params[:id])
    if @post.destroy
      flash[:notice] = "???????????????????????????"
      redirect_to public_homes_home_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title_id, :genre_id, :body, :image)
  end
end
