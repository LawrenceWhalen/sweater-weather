class GeoFacade

  def self.lat_lng(location)
    json = GeoService.get_geocoding(location)

    if !json[:error]
      lng = json[:results].first[:locations].first[:displayLatLng][:lng]
      lat = json[:results].first[:locations].first[:displayLatLng][:lat]
      { lat: lat, lng: lng }
    else
      json
    end
  end
  
  def self.route_time(locations)
    json = GeoService.geo_route(locations)[:route]

    if !json[:realTime]
      { error: [route: 'Cannot find possible route'] }
    elsif json[:realTime] == 10000000
      { error: [route: 'All possible routes are currently closed'] }
    else
      { route_time: json[:realTime] }
    end
  end
end