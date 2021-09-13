class Public::SearchsController < ApplicationController
  before_action :authenticate_end_user!

  def search
   @genres = Genre.all
  end

  def  post_search
   if params[:body] != ""
    @posts =  Post.where("body LIKE(?)","%#{params[:body]}%").order(created_at: :desc).page(params[:page]).per(15)
   else
    @posts = Post.all.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(15)
   end
   case params[:order]
   when 'seatch'
    @genres = Genre.find(params[:id])
    @posts = @genres.posts.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(15)
   end
  end

  def  title_search
   if params[:body] != ""
    @titles = Title.where("body LIKE(?)","%#{params[:body]}%").order(created_at: :desc).page(params[:page]).per(15)
   else
    @titles = Title.all.order(created_at: :desc).page(params[:page]).eager_load(:end_user).per(15)
   end
   case params[:order]
   when 'seatch'
    @genres = Genre.find(params[:id])
    @titles = @genres.titles.all.order(created_at: :desc).page(params[:page]).eager_load(:end_user, :posts).per(15)
   end
  end
end
