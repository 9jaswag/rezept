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

require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = build(:user)
  end

  # after(:all) do
  #   User.delete_all
  # end

  it { should have_secure_password }

  it { should validate_presence_of(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
end
