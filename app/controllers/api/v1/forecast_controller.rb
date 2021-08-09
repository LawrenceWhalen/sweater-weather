class Api::V1::ForecastController < ApplicationController

  def index
    location_data = WeatherFacade.weather_return(params[:location])

    render json: WeatherSerializer.new(location_data)
  end
  
end