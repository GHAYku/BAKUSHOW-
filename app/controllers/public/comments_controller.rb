class Public::CommentsController < ApplicationController

  def create
    post = Post.find(params[:post_id])
    @comente = Comente.new(comentes_params)
    @comentes.end_user_id = current_end_user.id
    @comentes.post_id = post.id
    if @comentes.save
      flash[:success] = "コメントしました"
      redirect_to request.referer
    else
      flash[:success] = "コメントできませんでした"
      redirect_to request.referer
    end
  end

  def destroy
   @comentes = Comentes.find(params[:id])
   if @comentes.destroy
     flash[:notice]="コメントを削除しました"
     redirect_to request.referer
   end
  end

  private
  def comentes_params
   params.require(:comente).permit(:body)
  end
end
