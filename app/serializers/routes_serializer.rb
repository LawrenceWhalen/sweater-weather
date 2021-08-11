class RoutesSerializer
  include FastJsonapi::ObjectSerializer
  set_type :roadtrip
  set_id :id
  attributes :start_city, :end_city, :travel_time, :weather_at_eta
end