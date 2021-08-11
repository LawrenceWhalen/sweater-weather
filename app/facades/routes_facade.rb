class RoutesFacade

  def self.roadtrip(locations)
    time_seconds = GeoFacade.route_time(locations)
    return time_seconds if time_seconds[:error]

    hours = time_seconds[:route_time] / 3600 + 1
    weather = WeatherFacade.eta_weather(locations[:to], hours)

    RoutesPoro.new(
      start_city: locations[:from].insert(-3, ' '),
      end_city: locations[:to].insert(-3, ' '),
      travel_time: Time.at(time_seconds[:route_time]).utc.strftime("%H hours, %M minutes"),
      weather: weather
    )
  end

end