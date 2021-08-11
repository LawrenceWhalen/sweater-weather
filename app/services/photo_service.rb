class PhotoService
  def self.photo_by_coord(location)
    response = conn.get("/services/rest/?method=flickr.photos.search") do |conn|
      conn.params[:sort] = 'relevance'
      conn.params[:privacy_filter] = 1
      conn.params[:accuracy] = 11
      conn.params[:content_type] = 1
      conn.params[:media] = 'photos'
      conn.params[:sort] = 'relevance'
      conn.params[:lat] = location[:lat].to_i
      conn.params[:lon] = location[:lon].to_i
      conn.params[:per_page] = 1
      conn.params[:format] = 'json'
      conn.params[:nojsoncallback] = 1
    end

    parse_json(response)
  end

  def self.artist_account(user_id)
    response = conn.get("/services/rest/?method=flickr.profile.getProfile") do |conn|
      conn.params[:user_id] = user_id
      conn.params[:format] = 'json'
      conn.params[:nojsoncallback] = 1
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