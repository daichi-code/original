class Comment < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :notices, dependent: :destroy

  validates :text, presence: true

  def create_notice_comment!(current_user, comment_id)
    #同じ投稿にコメントしているユーザーに通知を送る。（current_userと投稿ユーザーのぞく）
    temp_ids = Comment.where(like_id: id).where.not("user_id=? or user_id=?", current_user.id,user_id).select(:user_id).distinct

    #取得したユーザー達へ通知を作成。（user_idのみ繰り返し取得）
    temp_ids.each do |temp_id|
      save_notice_comment!(current_user, comment_id, temp_id['user_id'])
    end

    #投稿者へ通知を作成
    save_notice_comment!(current_user, comment_id, user_id)
  end

  def save_notice_comment!(current_user, comment_id, visited_id)
      notice = current_user.active_notices.new(
        like_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )

      if notice.visitor_id == notice.visited_id
        notice.checked = true
      end

      notice.save if notice.valid?
  end
end
