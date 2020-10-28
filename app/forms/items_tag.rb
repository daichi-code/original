class ItemsTag

  include ActiveModel::Model
  attr_accessor :title, :text, :category_id, :prefecture_id, :season_id, :images, :message, :user_id, :item_id, :tag_id

  with_options presence: true do
    validates :title
    validates :text
    validates :category_id
    validates :prefecture_id
    validates :season_id
    validates :images
    validates :message
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :season_id
    validates :prefecture_id
  end



  def save

    item = Item.create(title: title, text: text, category_id: category_id, prefecture_id: prefecture_id, season_id: season_id, images: images, user_id: user_id)

    tag = Tag.where(message: message).first_or_initialize
    tag.save

    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)

  end

end