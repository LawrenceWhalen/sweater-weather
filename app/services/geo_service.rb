class GeoService

  def self.get_geocoding(location)
    response = conn.get("/geocoding/v1/address") do |conn|
      conn.params[:location] = location
      conn.params[:thumbMaps] = false
      conn.params[:addressmaxResults] = 1
      conn.params[:outFormat] = 'json'
    end
    
    response_hash = parse_json(response)

    if response_hash[:results][0][:locations][0][:adminArea1] == 'US'
      response_hash
    else
      { error: [location: 'city not found'] }
    end
  end

  def self.geo_route(locations)
    response = conn.get('/directions/v2/route') do |conn|
      conn.params[:from] = locations[:from]
      conn.params[:to] = locations[:to]
    end

    parse_json(response)
  end

  private

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com') do |faraday|
      faraday.params[:key] = ENV['GEO_API']
    end
  end
end