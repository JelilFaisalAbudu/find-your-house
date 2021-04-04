class Api::V1::AuthenticationsController < ApplicationController
  skip_before_action :authorize_request, only: %i[create]

  def create
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).user
    decoded = JsonWebToken.decode(auth_token)
    user = User.find_by(id: decoded[:user_id])
    response = {
      id: user[:id],
      name: user[:name],
      auth_token: auth_token
    }
    json_response(response, :created)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
