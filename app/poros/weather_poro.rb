class WeatherPoro
  attr_reader :id,
              :attributes

  def initialize(weather_hash)
    @id = nil
    @attributes = weather_hash   
  end

end