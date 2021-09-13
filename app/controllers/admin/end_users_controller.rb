class Admin::EndUsersController < ApplicationController
 before_action :authenticate_admin!
 
  def index
   @end_users = EndUser.all.order(created_at: :desc).page(params[:page]).per(15)
  end

  def edit
   @end_user = EndUser.find(params[:id])
  end

  def update
   @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      flash[:notice] = "編集しました"
      redirect_to admin_end_users_path
    else
      render :edit
    end
  end

  def destroy
   @end_user = EndUser.find(params[:id])
   if @end_user.destroy
     flash[:notice]="削除しました"
     redirect_to admin_end_users_path
   end
  end

  private
  def end_user_params
   params.require(:end_user).permit(:name, :body, :image, :email, :is_active)
  end
end
