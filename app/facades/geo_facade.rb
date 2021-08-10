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
  
end