# frozen_string_literal: true

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

class User < ApplicationRecord
  attr_accessor :activation_token, :reset_token
  before_save { self.email = email.downcase }
  before_save { self.username = username.downcase }
  before_create :create_activation_digest

  has_many :recipis, foreign_key: :owner_id, class_name: 'Recipi'

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :username, presence: true, length: { maximum: 15 }, uniqueness: true
  validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  class << self
    # returns a random token
    def new_token
      SecureRandom.urlsafe_base64
    end

    # returns the hash digest of a given string
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  end

  # sends email with activation link
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  # sends email with password reset link
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # returns true if a token matches the digest
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    # verify the token matches the digest
    BCrypt::Password.new(digest).is_password?(token)
  end

  # activate a user
  def activate
    update_columns(activated: true, activated_time: Time.zone.now)
  end

  # activate user account
  def activate_user(token)
    unless self && !activated && authenticated?(:activation, token)
      raise(
        ExceptionHandler::BadRequest,
        'Account activation failed!'
      )
    end
    activate
    true
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_columns(
      reset_digest: User.digest(reset_token),
      reset_time: Time.zone.now
    )
  end

  def password_reset_expired?
    if reset_time && reset_time > 2.hours.ago
      true
    else
      raise(ExceptionHandler::ExpiredSignature, 'Reset token is expired')
    end
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end
