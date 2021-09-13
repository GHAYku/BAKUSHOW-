class Public::CommentsController < ApplicationController
 

  def create
    post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.end_user_id = current_end_user.id
    @comment.post_id = post.id
    if @comment.save
      flash[:notice] = "コメントしました"
      redirect_to request.referer
    else
      flash[:danger] = "コメントできませんでした。内容を確認してください。コメントの入力は120文字以内です。"
      redirect_to request.referer
    end
  end

  def destroy
    post = Post.find(params[:post_id])
    comment = post.comments.find(params[:id])
   if comment.destroy
     flash[:notice]="コメントを削除しました"
     redirect_to request.referer
   end
  end

  private
  def comment_params
   params.require(:comment).permit(:comment)
  end
end
