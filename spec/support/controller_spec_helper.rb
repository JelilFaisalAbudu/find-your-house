module ControllerSpecHelper
  # Generate token from user ID
  def generate_token(user_id)
    JsonWebToken.encode(user_id: user_id)
  end

  # Generate an expired token from user ID
  def generate_expire_token(user_id)
    JsonWebToken.encode({ user_id: user_id }, (Time.now.to_i - 48))
  end

  # Return valid headers
  def valid_headers
    {
      Authorization: generate_token(user.id),
      'Content-Type' => 'application/json'
    }
  end

  # return invalid headers
  def invalid_headers
    {
      Authorization: nil,
      'Content-Type' => 'application/json'
    }
  end
end
