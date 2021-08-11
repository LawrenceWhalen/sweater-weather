class PhotoPoro
  attr_reader :location,
              :image_url,
              :credit,
              :id

  def initialize(attributes)
    @location = attributes[:location]
    @image_url = attributes[:image_url]
    @credit = attributes[:credit]
    @id = nil
  end
end