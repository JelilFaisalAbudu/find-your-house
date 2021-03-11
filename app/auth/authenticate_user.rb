class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def user
    JsonWebToken.encode(user_id: authenticate_user.id)
  end

  private

  attr_reader :email, :password

  def authenticate_user
    user = User.find_by(email: email)
    return user if user&.authenticate(password)

    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
