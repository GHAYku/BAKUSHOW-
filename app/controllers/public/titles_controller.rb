class Public::TitlesController < ApplicationController
  def index
   @titles = Title.order(created_at: :desc)
   case params[:order]
   when "my_titles"
    @titles = current_end_user.titles.page(params[:page]).per(15)
   end
  end

  def new
   @title = Title.new
  end

  def show
   @title = Title.find(params[:id])
   @posts = @title.posts.order(created_at: :desc)
   @post = Post.new
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

  def confirmation
  end

  private
  def title_params
   params.require(:title).permit(:genre_id, :body, :image)
  end
end
