class Public::SearchsController < ApplicationController
  before_action :authenticate_end_user!
  before_action :set_right_menu

  def set_right_menu
    @review = Review.new
    @ranking_users = EndUser.find(Post.group(:end_user_id).joins(:reviews).order('sum(rate) desc').pluck(:end_user_id))
    @random = Post.all.sample
  end

  def search
    @genres = Genre.all
  end

  def post_search
    if params[:body] != ""
      @posts = Post.search(params[:body]).order(created_at: :desc).page(params[:page]).per(5)
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(5)
    end
    case params[:order]
    when 'seatch'
      @genres = Genre.find(params[:id])
      @posts = @genres.posts.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user, :title).per(5)
    end
  end

  def title_search
    if params[:body] != ""
      @titles = Title.tite_search(params[:body]).order(created_at: :desc).page(params[:page]).per(5)
    else
      @titles = Title.all.order(created_at: :desc).page(params[:page]).eager_load(:end_user).per(5)
    end
    case params[:order]
    when 'seatch'
      @genres = Genre.find(params[:id])
      @titles = @genres.titles.all.order(created_at: :desc).page(params[:page]).eager_load(:end_user, :posts).per(5)
    end
  end
end
