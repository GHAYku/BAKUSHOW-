class Public::PostsController < ApplicationController
  before_action :authenticate_end_user!

  def index
    @posts = Post.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(5)
    @review = Review.new
    case params[:order]
    when "home"
      @posts = Post.where(end_user_id: [current_end_user.id, * current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(5)
      @review = Review.new
    when "new"
      @posts = Post.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(5)
      @review = Review.new
    when "popular"
      posts = Post.find(Review.group(:post_id).order('sum(rate) desc').pluck(:post_id))
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(5)
    when "myposts"
      @posts = current_end_user.posts.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(5)
      @review = Review.new
    when "reviews"
      @reviews = Review.where(end_user_id: [current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
      @review = Review.new
    when "myreviews"
      @reviews = current_end_user.reviews.order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
      @review = Review.new
    end
  end

  def title_posts_index
    @posts = Post.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(5)
    @review = Review.new
    case params[:order]
    when "home"
      @posts = Post.where(end_user_id: [current_end_user.id, * current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(5)
      @review = Review.new
    when "new"
      @posts = Post.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(5)
      @review = Review.new
    when "popular"
      posts = Post.find(Review.group(:post_id).order('sum(rate) desc').pluck(:post_id))
      @posts = Kaminari.paginate_array(posts).page(params[:page]).per(5)
    when "myposts"
      @posts = current_end_user.posts.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(5)
      @review = Review.new
    when "reviews"
      @reviews = Review.where(end_user_id: [current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
      @review = Review.new
    end
  end

  def reviews_index
    @reviews = Review.order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
    @review = Review.new
    case params[:order]
    when "reviews"
      @reviews = Review.where(end_user_id: [current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
      @review = Review.new
    when "myreviews"
      @reviews = current_end_user.reviews.order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
      @review = Review.new
    end
  end

  def title_reviews_index
    @reviews = Review.order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
    @review = Review.new
    case params[:order]
    when "reviews"
      @reviews = Review.where(end_user_id: [current_end_user.following_ids]).order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
      @review = Review.new
    when "myreviews"
      @reviews = current_end_user.reviews.order(created_at: :desc).page(params[:page]).eager_load(:post, :end_user).per(5)
      @review = Review.new
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
    @review = Review.new
  end

  def create
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    if @post.save
      flash[:notice] = "投稿しました"
      redirect_to public_homes_home_path
    else
      flash[:danger] = "投稿に失敗しました。ジャンルか投稿内容を確認してください。投稿内容の入力は60文字以内です。"
      redirect_to request.referer
    end
  end

  def update
    @post = current_end_user.posts.find(params[:id])
    if @post.update(post_params)
      flash[:notice] = "投稿内容を編集しました"
      redirect_to public_homes_home_path
    else
      flash[:danger] = "投稿内容の編集に失敗しました。ジャンルか投稿内容を確認してください。投稿内容の入力は60文字以内です。"
      redirect_to request.referer
    end
  end

  def destroy
    @post = current_end_user.posts.find(params[:id])
    if @post.destroy
      flash[:notice] = "投稿を削除しました"
      redirect_to public_homes_home_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title_id, :genre_id, :body, :image)
  end
end
