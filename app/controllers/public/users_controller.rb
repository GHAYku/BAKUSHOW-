class Public::UsersController < ApplicationController
  def show
  end

  def edit
   @end_user = current_end_user
  end

  def favorite
  end

  def update
   @end_user = current_end_user
    if @end_user.update(end_user_params)
      flash[:notice] = "#{@end_user.name}さんの会員情報を編集しました"
      redirect_to edit_public_user_path
    else
      render :edit
    end
  end

  def withdraw
    end_user = current_end_user
    end_user.update(is_active: false)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  private
  def end_user_params
   params.require(:end_user).permit(:name, :body, :image, :email, :is_active)
  end
end