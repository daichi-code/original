class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :season
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :title
    validates :text
    validates :category_id
    validates :prefecture_id
    validates :season_id
    validates :image
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :season_id
    validates :prefecture_id
  end

end

