class ItemsTag

  include ActiveModel::Model
  attr_accessor :title, :text, :category_id, :prefecture_id, :season_id, :images, :name

  with_options presence: true do
    validates :title
    validates :text
    validates :category_id
    validates :prefecture_id
    validates :season_id
    validates :images
    validates :name
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :season_id
    validates :prefecture_id
  end



  def save
    tag = Tag.where(name: name).first_or_initialize

    ItemTagRelation.create(item_id: item.id, tag_id: tag.id)
  end

end