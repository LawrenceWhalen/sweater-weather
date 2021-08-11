class Api::V1::RoadTripController < ApplicationController

  def create
    route_params = JSON.parse(request.body.read, symbolize_names: true)
    city_error = locations_error(route_params)

    if !ApiKey.find_by(token: route_params[:api_key])
      json = { error: [api_key: 'api key is missing or incorrect'] }
    elsif city_error
      json = city_error
    else
      route_found = RoutesFacade.roadtrip(from: route_params[:origin], to: route_params[:destination])
      if route_found.class != RoutesPoro
        json = route_found
      else
        json = RoutesSerializer.new(route_found)
      end
    end

    render json: json
  end

  private

  def locations_error(route_check)
    check_result_to = location_check(route_check[:destination])
    check_result_from = location_check(route_check[:origin])
    check_city_to = GeoService.get_geocoding(route_check[:destination])
    check_city_from = GeoService.get_geocoding(route_check[:origin])
    if check_city_to[:error] || check_city_from[:error]
      check_city_to if check_city_to[:error]
      check_city_from if check_city_from[:error]
    elsif check_result_to || check_result_from
      check_result_to if check_result_to
      check_result_from if check_result_from
    else
      nil
    end
  end
end