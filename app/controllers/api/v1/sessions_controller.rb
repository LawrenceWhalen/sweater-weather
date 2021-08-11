class Api::V1::SessionsController < ApplicationController

  def create
    user_params = JSON.parse(request.body.read, symbolize_names: true)

    user = User.find_by(email: user_params[:email])
      
    if user == nil
      login_error
    elsif user.authenticate(user_params[:password])
      render json: UserSerializer.new(user.user_and_api_key), status: 200
    else
      login_error
    end
  end

  private

  def login_error
    render json: 
      { 
        error: [user: 'email or password incorrect', status: '404 Not Found'],
        message: 'Entity not found.'
      }, status: :not_found
  end
  
end