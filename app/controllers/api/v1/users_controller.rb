class Api::V1::UsersController < ApplicationController

  def create
    user_params = JSON.parse(request.body.read, symbolize_names: true)

    user = user_strong(user_params)
    user.save!
    ApiKey.add_api_key(user)

    render json: UserSerializer.new(user.user_and_api_key), status: 201
  end

  private

  def user_strong(user_attributes)
    User.new(
      email: user_attributes[:email],
      password: user_attributes[:password],
      password_confirmation: user_attributes[:password_confirmation]
    )
  end
end