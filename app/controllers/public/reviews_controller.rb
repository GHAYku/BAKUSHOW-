class Public::ReviewsController < ApplicationController
   def create
    post = Post.find(params[:post_id])
    @review = Review.new(review_params)
    @review.end_user_id = current_end_user.id
    @review.post_id = post.id
     if @review.save!
      flash[:success] = "オモローしました！"
      redirect_to request.referer
     else
      flash[:success] = "オモローできませんでした。"
      render :show
     end
   end

   def edit
    @review = Review.find(params[:id])
   end

   def update
    @review = Review.find(params[:id])
     if @review.update(review_params)
      flash[:success] = "オモローの編集をしました！"
      redirect_to request.referer
     else
      flash[:success] = "オモローの編集ができませんでした。"
      redirect_to request.referer
     end
   end

  private
  def review_params
   params.require(:review).permit(:rate)
  end
end
