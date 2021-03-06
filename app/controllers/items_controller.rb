class ItemsController < ApplicationController
  before_action :set_item, only: [:edit, :update, :show, :destroy]
  before_action :move_to_index, only: [:edit]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @items = Item.page(params[:page]).reverse_order
    @like = Like.new

    @item = Item.find(Like.group(:item_id).order('count(item_id) desc').limit(1).pluck(:item_id))
  end

  def new
    @item = ItemsTag.new
  end

  def create
    @item = ItemsTag.new(item_params)
    if @item.valid?
      @item.save
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
    @like = Like.new
  end

  def search
    @items = Item.search(params[:keyword])
    @item = Item.page(params[:page]).reverse_order
  end

  def search_tag
    return nil if params[:keyword] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:keyword]}%"] )
    render json:{ keyword: tag }
  end





  private
  def item_params
    params.require(:items_tag).permit(:text, :season_id, :category_id, :prefecture_id, :message, images: []).merge(user_id: current_user.id, item_id: params[:item_id], tag_id: params[:tag_id])
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    @item = Item.find(params[:id])
    redirect_to action: :index unless user_signed_in? && current_user.id == @item.user.id
  end
end
