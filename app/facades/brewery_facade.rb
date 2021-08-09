class BreweryFacade

  def self.by_city(destination, quantity)
    location = GeoFacade.get_geocoding(destination)
    breweries = AaService.by_location(location, quantity)
    weather = WeatherFacade.current_brew

    brewery_list = breweries.map do |brewery|
      id: brewery[:id], name: brewery[:name], brewery_type: brewery[:brewery_type]
    end

    
  end
  
end