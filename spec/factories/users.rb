FactoryBot.define do
  factory :user do
    username { "MyString" }
    email { "MyString" }
    password_digest { "MyString" }
    reset_digest { "MyString" }
    reset_time { "2018-10-22 15:47:06" }
    activation_digest { "MyString" }
    activated { false }
    activated_time { "2018-10-22 15:47:06" }
    is_admin { false }
  end
end
