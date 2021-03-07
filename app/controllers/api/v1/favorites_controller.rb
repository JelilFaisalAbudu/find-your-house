class Api::V1::FavoritesController < ApplicationController
  before_action :set_user, only: [:index, :create]
  # before_action :set_house, only: [:create]

  def index
    @user_favorites = @user.favorites
    json_response(@user_favorites)
  end
    
  def create
    @favorite = @user.favorites.create!(house_id: params[:house_id])
    json_response(@favorite, :created)
  end
  

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_house
    @house = House.find(params[:house_id])
  end
end
