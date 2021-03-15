class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def user
    { user: find_user }
  end

  private

  attr_reader :headers

  def find_user
    @user ||= User.find(decode_auth_token[:user_id]) if decode_auth_token
  rescue ActiveRecord::RecordNotFound => e
    raise(
      ExceptionHandler::InvalidToken,
      ("#{Message.invalid_token} #{e.message}")
    )
  end

  def decode_auth_token
    @decode_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return headers[:Authorization].split(' ').last if headers[:Authorization].present?

    raise(ExceptionHandler::MissingToken, Message.missing_token)
  end
end
