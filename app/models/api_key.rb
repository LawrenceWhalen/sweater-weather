class ApiKey < ApplicationRecord
  belongs_to :bearer, polymorphic: true

  def self.add_api_key(user)
    ApiKey.create!(bearer: user, token: SecureRandom.hex)
  end
  
end