class AaService
  def self.by_location(location, quantity)
    response = conn.get("/breweries") do |conn|
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
    Faraday.new(url: 'https://api.openbrewerydb.org') do |faraday|
      
    end
  end
end