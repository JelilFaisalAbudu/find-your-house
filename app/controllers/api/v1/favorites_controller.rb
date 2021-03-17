class Api::V1::FavoritesController < ApplicationController
  before_action :set_favorite, only: %i[destroy]
  before_action :check_owner, only: %i[destroy]

  def index
    current_user_favorites = current_user.favorite_houses
    json_response(current_user_favorites)
  end

  def create
    @favorite = current_user.favorites.create!(house_id: params[:house_id])
    json_response(@favorite, :created)
  end

  def destroy
    @favorite.destroy
    head :no_content
  end

  private

  def set_favorite
    @favorite = Favorite.find(params[:id])
  end

  def check_owner
    head :forbidden unless @favorite.user_id == current_user&.id
  end
end
