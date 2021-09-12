class Public::TitlesController < ApplicationController
  def index
   @titles = Title.order(created_at: :desc).page(params[:page]).eager_load(:posts,:end_user).per(15)
   case params[:order]
   when "my_titles"
    @titles = current_end_user.titles.page(params[:page]).eager_load(:posts,:end_user).per(15)
   end
  end

  def new
   @title = Title.new
  end

  def show
   @title = Title.find(params[:id])
   @posts = @title.posts.order(created_at: :desc).page(params[:page]).eager_load(:reviews, :end_user).per(15)
   @post = Post.new
   @review = Review.new
  end

  def create
    @title = Title.new(title_params)
    @title.end_user_id = current_end_user.id
    if @title.save
      flash[:notice]="お題の作成を完了しました！"
      redirect_to public_titles_path
    else
      render :new
    end
  end

  def edit
   @title = current_end_user.titles.find(params[:id])
  end

  def update
   @title = current_end_user.titles.find(params[:id])
    if @title.update(title_params)
      flash[:notice] = "このお題を編集しました"
      redirect_to public_titles_path
    else
      render :edit
    end
  end

  def destroy
   @title = current_end_user.titles.find(params[:id])
   if @title.destroy
     flash[:notice]="この投稿を削除しました"
     redirect_to public_titles_path
   end
  end

  private
  def title_params
   params.require(:title).permit(:genre_id, :body, :image)
  end
end
