class BrewerySerializer
  include FastJsonapi::ObjectSerializer
  set_type :breweries
  set_id :id
  attributes :destination, :forecast, :breweries
end