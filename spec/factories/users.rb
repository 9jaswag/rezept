# == Schema Information
#
# Table name: users
#
#  id                :bigint(8)        not null, primary key
#  activated         :boolean
#  activated_time    :datetime
#  activation_digest :string
#  email             :string
#  is_admin          :boolean          default(FALSE)
#  password_digest   :string
#  reset_digest      :string
#  reset_time        :datetime
#  username          :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email)
#  index_users_on_username  (username)
#

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
