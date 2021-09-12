class Admin::CommentsController < ApplicationController
  def index
   @comments = Comment.all.order(created_at: :desc).page(params[:page]).per(15)
  end

  def edit
   @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    if @post.update(comment_params)
      flash[:notice] = "編集しました"
      redirect_to admin_comments_path
    else
      render :edit
    end
  end

  def destroy
   @comment = Comment.find(params[:id])
   if @comment.destroy
     flash[:notice]="この投稿を削除しました"
     redirect_to admin_comments_path
   end
  end

  private
  def comment_params
   params.require(:comment).permit(:comment)
  end
end
