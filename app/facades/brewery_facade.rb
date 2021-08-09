class BreweryFacade

  def self.by_city(destination, quantity)
    location = GeoFacade.lat_lng(destination)
    if location[:error]
      return location
    end
    breweries = AaService.by_location(location, quantity)
    weather = WeatherFacade.current_brew(destination)

    brewery_list = breweries.map do |brewery|
      {id: brewery[:id], name: brewery[:name], brewery_type: brewery[:brewery_type]}
    end

    BreweryPoro.new(
      forecast: weather,
      destination: destination,
      breweries: brewery_list
    )
  end
  
end