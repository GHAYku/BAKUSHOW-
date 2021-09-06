class Public::PostsController < ApplicationController

  def index
   case params[:order]
   when "home"
    @posts = Post.where(end_user_id:[current_end_user.id, * current_end_user.follower_ids]).order(created_at: :desc)
    @review = Review.new
   when "new"
    @posts = Post.order(created_at: :desc)
    @review = Review.new
   when "popular"
    @posts = Post.find(Review.group(:post_id).order('sum(rate) desc').pluck(:post_id))
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
   @comments = @post.comments
   @comment = Comment.new
   @review = Review.new
   @reviews = @post.reviews
   #@review_count = Review.where(post_id: params[:post_id]).where(end_user_id: current_end_user.id).count
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