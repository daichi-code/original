class CommentsController < ApplicationController

  def new
    @comments = Comment.all
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to item_path(@comment.item_id)
      # ActionCable.server.broadcast 'comment_channel', content: @comment
    else
      redirect_to item_path(@comment.item_id)
    end

    # @comment.like_id = params[:like_id]
    # if @comment.save
    #   flash[:success] = 'コメントしました'
    #   #通知機能用
    #   @like = @comment.like
    #   @like.create_notice_comment!(current_user, @comment.id)
    #   #ここまで通知機能
    #   redirect_to @comment.like
    # else
    #   comments_get
    #   render template: 'likes/show'
    # end
  end



  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
