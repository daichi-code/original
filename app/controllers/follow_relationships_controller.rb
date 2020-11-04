class FollowRelationshipsController < ApplicationController

  def create
    @user =User.find(params[:follow_relationship][:following_id])
    current_user.follow(@user)
    if @user.save
      redirect_to @user, flash: {success: 'フォローしました!'}
    else
      redirect_to root_path
    end
  end

  def destroy
    @user = User.find(params[:follow_relationship][:following_id])
    current_user.unfollow(@user)
    if @user.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

end
