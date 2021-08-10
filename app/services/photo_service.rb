class AaService
  def self..photo_by_coord(location_hash)
    response = conn.get("/services/rest/") do |conn|
      conn.params[:by_dist] = "#{location[:lat]},#{location[:lng]}"
      conn.params[:per_page] = quantity
    end

    parse_json(response)
  end

  private

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn
    Faraday.new(url: 'https://www.flickr.com') do |faraday|
      faraday.params[:api_key] = ENV['PHOTO_API']
    end
  end
end

?method=flickr.photos.search&api_key=&text=Texarkana&sort=relevance&privacy_filter=1&accuracy=11&safe_search=1&content_type=1&media=photos&has_geo=1&geo_context=2&lat=33.44&lon=-94.04&per_page=1&format=json&nojsoncallback=1