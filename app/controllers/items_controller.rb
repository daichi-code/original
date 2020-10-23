class ItemsController < ApplicationController
  def index
    @items = Item.all.order('id DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
  end


  private
  def item_params
    params.require(:item).permit(:title, :text, :season_id, :category_id, :prefecture_id, :image).merge(user_id: current_user.id)
  end
end
