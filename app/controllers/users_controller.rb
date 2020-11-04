class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @nickname = @user.nick_name
    @items = @user.items
  end

  # # @userがフォローしているユーザー一覧
  # def following
  #   @user = User.find(params[:user_id])
  #   @followings = @user.following_user
  # end

  # # @userをフォローしているユーザー一覧
  # def follower
  #   @user = User.find(params[:user_id])
  #   @followers = @user.follower_user
  # end
end
