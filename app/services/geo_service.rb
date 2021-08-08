class GeoService

  def self.get_geocoding(location)
    response = conn.get("/geocoding/v1/address?&location=#{location}&thumbMaps=false&maxResults=1&outFormat=json")

    parse_json(response)
  end

  private

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn(auth_token = nil)
    Faraday.new(url: 'http://www.mapquestapi.com') do |faraday|
      faraday.params[:key] = ENV['GEO_API']
    end
  end
end