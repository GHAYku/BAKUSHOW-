class Public::TitlesController < ApplicationController
  before_action :authenticate_end_user!
  before_action :set_right_menu, except: [:destroy,:create,:update]

  def set_right_menu
    @review = Review.new
    @ranking_users = EndUser.find(Post.group(:end_user_id).joins(:reviews).order('sum(rate) desc').pluck(:end_user_id))
    @random = Post.all.sample
  end

  def index
    @titles = Title.order(created_at: :desc).page(params[:page]).eager_load(:posts, :end_user).per(5)
    case params[:order]
    when "my_titles"
      @titles = current_end_user.titles.page(params[:page]).eager_load(:posts, :end_user).per(5)
    end
  end

  def new
    @title = Title.new
  end

  def show
    @title = Title.find(params[:id])
    @posts = @title.posts.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(5)
    @post = Post.new
  end

  def create
    @title = Title.new(title_params)
    @title.end_user_id = current_end_user.id
    if @title.save
      flash[:notice] = "お題の作成を完了しました！"
      redirect_to public_titles_path
    else
      flash[:danger] = "お題の作成に失敗しました。お題内容かジャンルを確認してみてください。お題内容の入力は120文字以内です。"
      render :new
    end
  end

  def edit
    @title = Title.find(params[:id])
    if @title.end_user.id != current_end_user.id
      redirect_to public_homes_home_path
    end
  end

  def update
    @title = current_end_user.titles.find(params[:id])
    if @title.update(title_params)
      flash[:notice] = "お題を編集しました。"
      redirect_to public_titles_path
    else
      flash[:danger] = "お題の編集に失敗しました。お題内容かジャンルを確認してみてください。お題内容の入力は120文字以内です。"
      render :edit
    end
  end

  def destroy
    @title = current_end_user.titles.find(params[:id])
    if @title.destroy
      flash[:notice] = "お題を削除しました"
      redirect_to public_titles_path
    end
  end

  private

  def title_params
    params.require(:title).permit(:genre_id, :body, :image)
  end
end
