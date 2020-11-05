class Like < ApplicationRecord
  belongs_to :item
  belongs_to :user
  has_many :notices, dependent: :destroy

  validates_uniqueness_of :item_id, scope: :user_id

  def create_notice_like!(current_user)
    temp = Notice.where(["visitor_id = ? and visited_id = ? and like_id = ? and action = ? ", current_user.id, user_id, id, 'like'])

    if temp.blank?
      notice = current_user.active_notices.new(
        like_id: id,
        visited_id: user_id,
        action: 'like'
      )

      if notice.visitor_id == notice.visited_id
        notice.checked = true
      end
      notice.save if notice.valid?
    end
  end
end
