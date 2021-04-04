class Message
  def self.not_found(record = 'record')
    "Sorry, #{record} not found"
  end

  def self.invalid_token
    'Invalid token'
  end

  def self.invalid_credentials
    'Invalid credentials'
  end

  def self.missing_token
    'Missing token'
  end

  def self.unauthorized
    'Unauthorized request'
  end

  def self.account_created
    'Account successfully created'
  end

  def self.expired_token
    'Sorry, your token has expired. Please login again'
  end

  def self.account_not_created
    'Account not created'
  end
end
