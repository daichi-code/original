class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :move_to_index, only: [:edit]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.all.order('id DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    if user_signed_in? && current_user.id == @item.user_id
      @item.destroy
      redirect_to root_path
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
    @comments = @item.comments.includes(:user)
  end

  def search
    @items = Item.search(params[:keyword])
  end

  private
  def item_params
    params.require(:item).permit(:title, :text, :season_id, :category_id, :prefecture_id, images: []).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    @item = Item.find(params[:id])
    redirect_to action: :index unless user_signed_in? && current_user.id == @item.user.id
  end
end
