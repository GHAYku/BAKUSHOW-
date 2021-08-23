class Public::RelationshipsController < ApplicationController
 def create 
  current_user.follow(params[:end_user_id])
  redirect_to request.referer 
 end

 def destroy 
  current_user.unfollow(params[:end_user_id])
  redirect_back(fallback_location: root_path)
 end

 def follower 
  end_user = EndUser.find(params[:end_user_id])
  @users = end_user.following_user
 end

 def followed 
  end_user = EndUser.find(params[:end_user_id])
  @users = end_user.follower_user
 end
end
