class Api::V1::BackgroundsController < ApplicationController

  def index
    check_result = location_check(params[:location])

    if check_result
      json = check_result
    else
      background = PhotoFacade.retrieve_photo_with_credit(params[:location])
      if background.class != PhotoPoro
        json = background
      else
        json = BackgroundSerializer.new(background)
      end
    end

    render json: json
  end
  
end