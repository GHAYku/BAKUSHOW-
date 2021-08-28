class Public::PostsController < ApplicationController

  def index
   @user = current_end_user
   @posts = @user.posts.order(created_at: :desc)
   case params[:another_user]
   when 'seatch'
     @user = EndUser.find(params[:id])
     @posts = @user.posts.order(created_at: :desc)
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
  end

  def create
   @post = Post.new(post_params)
   @post.end_user_id = current_end_user.id
   if @post.save
     flash[:notice] = "投稿しました！"
     redirect_to public_posts_path
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
   params.require(:post).permit(:genre_id, :body, :image)
  end
end