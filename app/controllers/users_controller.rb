class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @nickname = @user.nick_name
    @items = @user.items
  end

end
