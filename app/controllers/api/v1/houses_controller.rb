class Api::V1::HousesController < ApplicationController
  skip_before_action :authorize_request
  def index
    @houses = House.all
    json_response(@houses)
  end

  def create
    @house = House.create!(house_params)
    json_response(@house, :created)
  end

  private

  def house_params
    params.require(:house).permit(:name, :category, :description, :photo_url)
  end
end
