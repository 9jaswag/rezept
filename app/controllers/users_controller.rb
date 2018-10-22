class UsersController < ApplicationController
  skip_before_action :authorize_request, only: %i[create login edit update]
  def create
    user = User.create!(user_params)
    if user.save
      user.send_activation_email
      message = "Signup successful! Activation link sent to email."
      json_response(message, :created)
    else
      render json: user.errors, status: :bad
    end
  end

  # activate a user
  def edit
    user = User.find_by!(email: params[:email])
    user.activate_user(params[:token])
    message = "Account activation successful! Please log in"
    json_response(message, :created)
  end

  def update
    user = User.find_by!(email: params[:email])
    user.password_reset_expired?
    user.update!(reset_digest: nil, reset_time: nil) if user.update!(reset_params)
  end
  
  def reset
    user = User.find_by!(email: params[:email])
    user.create_reset_digest
    user.send_password_reset_email
  end

  def login
    # return auth token once user is authenticated
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).call
    message = 'User login successful!'
    json_response(message, :ok, auth_token)
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

  def json_response(message, status, auth_token = nil)
    response = { message: message, auth_token: auth_token }
    render json: response, status: status
  end
end
