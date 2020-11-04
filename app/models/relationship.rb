class Relationship < ApplicationRecord
  # フォローするユーザー
  belongs_to :follower, class_name: 'User'
  # フォローされるユーザー
  belongs_to :followed, class_name: 'User'

  validates :follower_id, presence: true
  validates :following_id, presence: true
end
