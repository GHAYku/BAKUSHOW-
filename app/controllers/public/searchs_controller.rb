class Public::SearchsController < ApplicationController
  def search
   @genres = Genre.all
  end

  def  post_search
   if params[:body] != ""
    @posts =  Post.where("body LIKE(?)","%#{params[:body]}%")
   else
    @posts = Post.all
   end
   case params[:order]
   when 'seatch'
    @genres = Genre.find(params[:id])
    @posts = @genres.posts.all
   end
  end

  def  title_search
   if params[:body] != ""
    @titles = Title.where("body LIKE(?)","%#{params[:body]}%")
   else
    @titles = Post.all
   end
   case params[:order]
   when 'seatch'
    @genres = Genre.find(params[:id])
    @titles = @genres.titles.all
   end
  end
end
