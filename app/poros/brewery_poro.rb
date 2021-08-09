class BreweryPoro
  attr_reader :id,
              :destination,
              :forecast,
              :breweries

  def initialize(attributes)
    @id = nil
    @destination = attributes[:destination]
    @forecast = attributes[:forecast]
    @breweries = attributes[:breweries]
  end
end