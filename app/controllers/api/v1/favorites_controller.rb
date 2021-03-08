class Api::V1::FavoritesController < ApplicationController
  before_action :set_user, only: %i[index create]
  before_action :set_favorite, only: %i[destroy]
  before_action :check_login, only: %i[create]
  before_action :check_owner, only: %i[destroy]

  def index
    @user_favorites = @user.favorites
    json_response(@user_favorites)
  end

  def create
    @favorite = @user.favorites.build(house_id: params[:house_id])
    if @favorite.save
      json_response(@favorite, :created)
    else

      json_response({ errors: @favorites.errors }, :unprocessable_entity)
    end
  end

  def destroy
    @favorite.destroy
    head :no_content
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  def check_owner
    head :forbidden unless @favorite.user_id == current_user&.id
  end
end
