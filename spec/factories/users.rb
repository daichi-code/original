FactoryBot.define do
  factory :user do
    nick_name {Faker::Name.last_name}
    email {Faker::Internet.free_email}
    password = 'aaa111'
    password {password}
    password_confirmation {password}
    first_name { '山田' }
    last_name { '太郎' }
    birthday { '2000-02-02' }
  end
end