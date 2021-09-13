class Public::EndUsersController < ApplicationController
  before_action :authenticate_end_user!
  before_action :ensure_normal_end_user, only: %i[update withdraw]


  def ensure_normal_end_user
   if current_end_user.email == 'guest@example.com'
    redirect_to root_path, alert: 'ゲストユーザーの更新・削除はできません。'
   end
  end

  def show
   @end_user = EndUser.find(params[:id])
   @posts = @end_user.posts.order(created_at: :desc).page(params[:page]).includes(:reviews, :end_user, :title).per(15)
   @review = Review.new
  end

  def posts_index
   @end_user = EndUser.find(params[:id])
   @posts = @end_user.posts.order(created_at: :desc).page(params[:page]).includes(:reviews, :end_user).per(15)
   @review = Review.new
  end

  def title_posts_index
   @end_user = EndUser.find(params[:id])
   @posts = @end_user.posts.order(created_at: :desc).page(params[:page]).includes(:reviews, :end_user, :title).per(15)
   @review = Review.new
  end

  def edit
   @end_user = current_end_user
  end

  def reviews_index
   @end_user = EndUser.find(params[:id])
   @reviews = @end_user.reviews.order(created_at: :desc).page(params[:page]).includes(:post, :end_user).per(15)
   @review = Review.new
  end

  def post_reviews_index
   @end_user = EndUser.find(params[:id])
   @reviews = @end_user.reviews.order(created_at: :desc).page(params[:page]).includes(:post, :end_user).per(15)
   @review = Review.new
  end

  def title_reviews_index
   @end_user = EndUser.find(params[:id])
   @reviews = @end_user.reviews.order(created_at: :desc).page(params[:page]).includes(:post, :end_user).per(15)
   @review = Review.new
  end


  def titles
   @end_user = EndUser.find(params[:id])
   @titles = @end_user.titles.order(created_at: :desc).page(params[:page]).includes(:posts,:end_user).per(15)
  end

  def update
   @end_user = current_end_user
    if @end_user.update(end_user_params)
      flash[:notice] = "#{@end_user.name}さんの会員情報を編集しました。"
      redirect_to edit_public_end_user_path
    else
      flash[:danger] = "#{@end_user.name}さんの会員情報の編集に失敗しました。名前かメールアドレスを確認してください。名前の入力は12文字以内です。"
      render :edit
    end
  end

  def withdraw
    end_user = current_end_user
    end_user.update(is_active: false)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private
  def end_user_params
   params.require(:end_user).permit(:name, :body, :image, :email, :is_active)
  end
end