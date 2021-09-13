class Public::RelationshipsController < ApplicationController
 before_action :authenticate_end_user!

  def create
    current_end_user.follow(params[:end_user_id])
    redirect_to request.referer
  end

  def destroy
    current_end_user.unfollow(params[:end_user_id])
    redirect_to request.referer
  end

  def follow_index
   @users = current_end_user.followings
   case  params[:order]
   when "followings"
    @users = current_end_user.followings
   when "followers"
    @users = current_end_user.followers
   end
  end


  def other_user_follow_index
   @users = current_end_user.followings
   case  params[:order]
   when "followings"
    @end_user = EndUser.find(params[:id])
    @users = @end_user.followings
   when "followers"
    @end_user = EndUser.find(params[:id])
    @users = @end_user.followers
   end
  end
end
