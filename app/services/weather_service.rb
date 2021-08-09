class WeatherService

  def self.one_weather(location_hash)
    response = conn.get("/data/2.5/onecall?&lon={lon}&exclude={part}") do |conn|
      conn.params[:lat] = location_hash[:lat]
      conn.params[:lon] = location_hash[:lng]
      conn.params[:exclude] = 'alerts,minutely'
      conn.params[:units] = 'imperial'
    end

    parse_json(response)
  end

  private

  def self.parse_json(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.conn(auth_token = nil)
    Faraday.new(url: 'https://api.openweathermap.org') do |faraday|
      faraday.params[:appid] = ENV['WEATHER_API']
    end
  end
end