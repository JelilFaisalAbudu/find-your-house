class Api::V1::UsersController < ApplicationController
  skip_before_action :authorize_request, only: %i[create]

  def create
    user = User.create!(user_params)
    auth_token = AuthenticateUser.new(user.email, user.password).user
    response = {
      id: user.id,
      name: user.name,
      message: Message.account_created,
      auth_token: auth_token
    }
    json_response(response, :created)
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
