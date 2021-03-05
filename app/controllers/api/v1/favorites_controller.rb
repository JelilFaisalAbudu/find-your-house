class Api::V1::FavoritesController < ApplicationController
  before_action :set_user, only: [:index,]

  def index
    @user_favorites = @user.favorites
    json_response(@user_favorites)
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
