class PhotoFacade

  def self.retrieve_photo_with_credit(location)
    location_hash = GeoFacade.lat_lng(location)

    return location_hash if location_hash[:error]

    photo = find_photo(location_hash)

    return photo if photo[:error]

    artist = find_author(photo[:user_id])
    
    PhotoPoro.new({
      location: location,
      image_url: photo[:url],
      credit: artist
    })
  end

  def self.find_photo(location_hash)
    raw_hash = PhotoService.photo_by_coord(location_hash)

    return { error: ['No picture found for location']} if raw_hash[:photos][:photo] == []

    photo_hash = raw_hash[:photos][:photo][0]

    { 
      url: "https://live.staticflickr.com/#{photo_hash[:server]}/#{photo_hash[:id]}_#{photo_hash[:secret]}.jpg",
      user_id: "#{photo_hash[:owner]}"
    }
  end

  def self.find_author(user_id)
    raw_owner = PhotoService.artist_account(user_id)

    {
      source: 'www.flickr.com',
      author: "#{raw_owner[:profile][:first_name]} #{raw_owner[:profile][:last_name]}",
      website: raw_owner[:profile][:website]
    }

  end
end