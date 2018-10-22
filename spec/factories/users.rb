FactoryBot.define do
  factory :user do
    username { Faker::Name.unique.first_name[1..15] }
    email { Faker::Internet.unique.email }
    password_digest { Faker::Crypto.md5 }
    reset_digest { Faker::Crypto.md5 }
    reset_time { Time.zone.now }
    activation_digest { Faker::Crypto.md5 }
    activated { false }
    activated_time { Time.zone.now }
    is_admin { false }
  end
end
