class WeatherFacade

  def self.weather_return(location)
    location_hash = GeoFacade.lat_lng(location)
    raw_data = WeatherService.one_weather(location_hash)

    current = current_hash(raw_data[:current])
    daily = daily_array(raw_data[:daily][0..4])
    hourly = hourly_array(raw_data[:hourly][0..7])

    WeatherPoro.new({
      current_weather: current,
      daily_weather: daily,
      hourly_weather: hourly
    })
  end

  private

  def self.current_hash(attributes)
    {
      datetime: Time.at(attributes[:dt]),
      sunrise: Time.at(attributes[:sunrise]),
      sunset: Time.at(attributes[:sunset]),
      temperature: attributes[:temp],
      feels_like: attributes[:feels_like],
      humidity: attributes[:humidity],
      uvi: attributes[:uvi],
      visibility: attributes[:visibility],
      conditions: attributes[:weather][0][:description],
      icon: attributes[:weather][0][:icon]
    }
  end

  def self.daily_array(attributes)
    attributes.map do |day|
      {
        date: Time.at(day[:dt]).strftime('%Y-%m-%d'),
        sunrise: Time.at(day[:sunrise]),
        sunset: Time.at(day[:sunset]),
        max_temp: day[:temp][:max],
        min_temp: day[:temp][:min],
        conditions: day[:weather][0][:description],
        icon: day[:weather][0][:icon]
      }
    end
  end

  def self.hourly_array(attributes)
    attributes.map do |hour|
      {
        time: Time.at(hour[:dt]).strftime('%H:%M:%S %z'),
        temperature: hour[:temp],
        conditions: hour[:weather][0][:description],
        icon: hour[:weather][0][:icon]
      }
    end
  end

end