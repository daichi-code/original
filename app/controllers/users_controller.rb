class UsersController < ApplicationController
  def show
    @nickname = current_user.nick_name
    @items = current_user.items
  end
end
