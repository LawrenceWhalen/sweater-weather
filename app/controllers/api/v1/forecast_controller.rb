class Api::V1::ForecastController < ApplicationController

  def index
    check_result = location_check(params[:location])

    if check_result
      json = check_result
    else
      weather_results = WeatherFacade.weather_return(params[:location])
      if weather_results.class != WeatherPoro
        json = weather_results
      else
        json = WeatherSerializer.new(weather_results)
      end
    end

    render json: json
  end
  
end