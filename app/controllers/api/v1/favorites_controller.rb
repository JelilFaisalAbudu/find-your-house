class Api::V1::FavoritesController < ApplicationController
  before_action :set_user, only: %i[index create]
  before_action :check_login, only: %i[create]
  # before_action :set_house, only: [:create]

  def index
    @user_favorites = @user.favorites
    json_response(@user_favorites)
  end

  def create
    @favorite = @user.favorites.build(house_id: params[:house_id])
    if @favorite.save
      json_response(@favorite, :created)
    else
      
      json_response({errors: @favorites.errors}, :unprocessable_entity)
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_house
    @house = House.find(params[:house_id])
  end
end
