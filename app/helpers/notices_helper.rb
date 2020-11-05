module NoticesHelper
  # def notice_form(notice)
  #   #通知を送ってきたユーザーを取得
  #   @visitor = notice.visitor
  #   #コメントの内容を通知に表示する
  #   @comment = nil
  #   @visitor_comment = notice.comment_id
  #   # notice.actionがfollowかlikeかcommentかで処理を変える
  #   case notice.action
  #   when 'follow'
  #     #aタグで通知を作成したユーザーshowのリンクを作成
  #     tag.a(notice.visitor.name, href: user_path(@visitor)) + 'があなたをフォローしました'
  #   when 'like'
  #     tag.a(notice.visitor.name, href: user_path(@visitor)) + 'が' + tag.a('あなたの投稿', href: like_path(notice.like_id)) + 'にいいねしました'
  #   when 'comment' then
  #     #コメントの内容と投稿のタイトルを取得
  #     @comment = Comment.find_by(id: @visitor_comment)
  #     @comment_content =@comment.content
  #     @like_title =@comment.like.title
  #     tag.a(@visitor.name, href: user_path(@visitor)) + 'が' + tag.a("#{@like_title}", href: like_path(notice.like_id)) + 'にコメントしました'
  #   end
end
