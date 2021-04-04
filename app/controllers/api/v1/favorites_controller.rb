class Api::V1::FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[destroy]

  def index
    current_user_favorites = current_user.favorites
    json_response(current_user_favorites)
  end

  def show
    @favorite = current_user.favorites.find_by(house_id: params[:house_id])
    json_response(@favorite)
  end

  def create
    @favorite = current_user.favorites.create!(house_id: params[:house_id])
    favorite_house = current_user.favorites.last
    json_response(favorite_house, :created)
  end

  def destroy
    @favorite.destroy
    head :no_content
  end

  private

  def set_favorite
    @favorite = Favorite.find_by(id: params[:id], user_id: params[:user_id])
  end

  def check_owner
    head :forbidden unless @favorite.user_id == current_user&.id
  end
end
