class User < ApplicationRecord
  has_secure_password
  validates :password_digest, presence: true
  validates :email, presence: true, uniqueness: true

  has_many :api_keys, as: :bearer

  def user_and_api_key
    UserApiKeyPoro.new(
      email: self.email,
      api_key: self.api_keys[0].token,
      id: self.id
    )
  end
end
