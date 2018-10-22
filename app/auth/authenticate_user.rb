class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :email, :password

  def user
    user ||= User.find_by(email: email)
    raise(ExceptionHandler::AuthenticationError, 'Account not activated') unless user.activated
    return user if user && user.authenticate(password)

    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, 'Invalid credentials')
  end
end