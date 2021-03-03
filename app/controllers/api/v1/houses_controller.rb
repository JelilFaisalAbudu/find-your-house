class Api::V1::HousesController < ApplicationController
  def index
    @houses = House.all
    json_response(@houses)
  end
end
