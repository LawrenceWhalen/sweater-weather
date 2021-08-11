class UserApiKeyPoro
  attr_reader :email,
              :api_key,
              :id

  def initialize(attributes)
    @email = attributes[:email]
    @api_key = attributes[:api_key]
    @id = attributes[:id]
  end
end