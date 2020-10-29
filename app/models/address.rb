class Address < ApplicationRecord
  belongs_to :user, optional: true

  with_options presence: true do
    validates :postal_code
    validates :address
    validates :prefecture_id, numericality: { other_than: 1 }
  end
end
