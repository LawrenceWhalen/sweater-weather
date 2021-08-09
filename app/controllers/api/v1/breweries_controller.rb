class Api::V1::BreweriesController < ApplicationController

  def index
    brewery_data = BreweryFacade.by_city(params[:location], params[:quantity])

    render json: BrewerySerializer.new(brewery_data)
  end
  
end