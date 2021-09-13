class Admin::GenresController < ApplicationController
before_action :authenticate_admin!

  def index
   @genres = Genre.all.order(created_at: :desc).page(params[:page]).per(15)
   @genre = Genre.new
  end

  def edit
   @genre = Genre.find(params[:id])
  end

  def update
   @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "編集しました"
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  def destroy
   @genre = Genre.find(params[:id])
   if @genre.destroy
     flash[:notice]="削除しました"
     redirect_to admin_titles_path
   end
  end

  def create
   @genre = Genre.new(genre_params)
    if @genre.save
      flash[:notice] = "編集しました"
      redirect_to admin_genres_path
    else
      render :edit
    end
  end

  private
  def genre_params
   params.require(:genre).permit(:name)
  end
end
