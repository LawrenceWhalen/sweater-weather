class Api::V1::BreweriesController < ApplicationController

  def index
    check_result = location_check(params[:location])
    quantity = quantity_check(params[:quantity])

    if check_result
      json = check_result
    else
      brewery_data = BreweryFacade.by_city(params[:location], quantity)
      json = BrewerySerializer.new(brewery_data)
    end

    render json: json
  end
  
end