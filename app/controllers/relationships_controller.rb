class RelationshipsController < ApplicationController

  # フォローする
  def follow
    @user = User.find(params[:id])
    current_user.follow(params[:id])
    render :create
  end

  # アンフォローする
  def unfollow
    @user = User.find(params[:id])
    current_user.unfollow(params[:id])
    render :destroy
  end

end
