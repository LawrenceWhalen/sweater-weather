class BackgroundSerializer
  include FastJsonapi::ObjectSerializer
  set_type :image
  set_id :id
  attributes :location, :image_url, :credit
end