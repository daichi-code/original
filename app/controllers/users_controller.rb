class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @nickname = @user.nick_name
    @items = @user.items
  end

  # @userがフォローしているユーザー一覧
  def followings
    @user =User.find(params[:id])
    @users =@user.followings.page(params[:page]).per(5)
    render 'show_followings'
  end

  # @userをフォローしているユーザー一覧
  def followers
    @user =User.find(params[:id])
    @users =@user.followers.page(params[:page]).per(5)
    render 'show_followers'
  end
end
