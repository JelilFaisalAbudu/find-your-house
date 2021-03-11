class Api::V1::AuthenticationsController < ApplicationController
  skip_before_action :authorize_request, only: %i[create]

  def create
    auth_token = AuthenticateUser.new(auth_params[:email], auth_params[:password]).user
    json_response({ auth_token: auth_token }, :created)
  end

  private

  def auth_params
    params.permit(:email, :password)
  end
end
