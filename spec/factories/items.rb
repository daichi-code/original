FactoryBot.define do
  factory :item do
    text { 'sample' }
    category_id { 2 }
    prefecture_id { 2 }
    season_id { 2 }
    association :user

    after(:build) do |item|
      item.images.attach(io: File.open('public/images/image.png'), filename: 'image.png')
    end
  end
end
