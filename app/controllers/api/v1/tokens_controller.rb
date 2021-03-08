class Api::V1::TokensController < ApplicationController
  def create
    @user = User.find_by_email(user_params[:email])
    if @user&.authenticate(user_params[:password])
      encoded = {
        token: JsonWebToken.encode(user_id: @user.id),
        email: @user.email,
        name: @user.name,
        id: @user.id
      }
      json_response(encoded, :created)
    else
      json_response({}, :unauthorized)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
