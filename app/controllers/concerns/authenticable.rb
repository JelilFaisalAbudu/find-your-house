module Authenticable
  def current_user
    return @current_user if @current_user

    header = request.headers['Authorization']
    return nil if header.nil?

    decoded = JsonWebToken.decode(header)
    @current_user = User.find(decoded[:user_id])
  end

  protected

  def check_login
    head :forbidden unless current_user
  end
end
