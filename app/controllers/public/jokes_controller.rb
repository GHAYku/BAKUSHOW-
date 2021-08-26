class Public::JokesController < ApplicationController
  def index
   @user = current_end_user
   @jokes = @user.joke.order(created_at: :desc)
   case params[:another_user]
   when 'seatch'
     @user = EndUser.find(params[:id])
     @jokes = @user.joke.order(created_at: :desc)
   end
  end

  def edit
   @joke = current_end_user.joke.find([params[:id]])
  end

  def new
   @joke = Joke.new
  end

  def show
   @joke = Joke.find([params[:id]])
  end

  def create
   @joke = Joke.new(joke_params)
   @joke.end_user_id = current_end_user.id
   if @joke.save
     flash[:notice] = "お題にボケました！"
     redirect_to public_joke_path
   else
     render :new
   end
  end

  def update
   @joke = current_end_user.joke.find([params[:id]])
    if @joke.update(joke_params)
      flash[:notice] = "このボケを編集しました"
      redirect_to public_joke_path
    else
      render :edit
    end
  end

  def destroy
   @joke = current_end_user.joke.find([params[:id]])
   if @joke.destroy
     flash[:notice]="このボケを削除しました"
     redirect_to public_joke_path
   end
  end

  private
  def joke_params
   params.require(:joke).permit(:title_id, :genre_id, :body, :image_id)
  end
end
