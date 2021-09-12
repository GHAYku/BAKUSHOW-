class Public::ReviewsController < ApplicationController
   def create
    post = Post.find(params[:post_id])
    @review = Review.new(review_params)
    @review.end_user_id = current_end_user.id
    @review.post_id = post.id
     if @review.save!
      flash[:success] = "評価しました！"
      redirect_to request.referer
     else
      flash[:success] = "評価できませんでした。"
      redirect_to request.referer
     end
   end

   def update
    @review = Review.find(params[:id])
     if @review.update(review_params)
      flash[:success] = "再評価しました！"
      redirect_to request.referer
     else
      flash[:success] = "再評価ができませんでした。"
      redirect_to request.referer
     end
   end

  private
  def review_params
   params.require(:review).permit(:rate)
  end
end
