class AuthenticateUser
  def initialize(email, password)
    @email = email
    @password = password
  end

  def user
    JsonWebToken.encode(user_id: find_user.id) if find_user
  end

  private

  attr_reader :email, :password

  def find_user
    user = User.find_by(email: email)
    return user if user&.authenticate(password)

    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end
