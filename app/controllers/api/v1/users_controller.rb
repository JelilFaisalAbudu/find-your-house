class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show]

  def show
    json_response(@user)
  end

  def create
    @user = User.create!(user_params)
    if @user.save
      json_response(@user, :created)
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
