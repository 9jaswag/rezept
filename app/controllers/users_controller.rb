# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authorize_request, only: %i[create login edit update]
  before_action :find_user, only: %i[edit update reset]

  def create
    user = User.create!(user_params)
    if user.save
      user.send_activation_email
      response = { message: 'Signup successful! Activation link sent to email.' }
      json_response(response, :created)
    else
      json_response(user.errors, :bad)
    end
  end

  # activate a user
  def edit
    @user.activate_user(params[:token])
    response = { message: 'Account activation successful! Please log in' }
    json_response(response)
  end

  def update
    @user.password_reset_expired?
    @user.update!(reset_digest: nil, reset_time: nil) if @user.update!(reset_params)
    response = { message: 'Password reset successful! Please log in' }
    json_response(response)
  end

  def reset
    @user.create_reset_digest
    @user.send_password_reset_email
    response = { message: 'Check your email for a password reset link' }
    json_response(response)
  end

  def login
    # return auth token once user is authenticated
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    response = { message: 'User login successful!', auth_token: auth_token }
    json_response(response)
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end

  def auth_params
    params.permit(:email, :password)
  end

  def reset_params
    params.permit(:password, :password_confirmation)
  end

  def find_user
    @user ||= User.find_by!(email: params[:email])
  end
end
