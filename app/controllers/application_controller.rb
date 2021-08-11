class ApplicationController < ActionController::API

  private

  def location_check(location)
    state_array = ["AK", "AL", "AR", "AZ", "CA", "CO", "CT", "DC",  
      "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA",  
      "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE",  
      "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "RI", "SC",  
      "SD", "TN", "TX", "UT", "VA", "VT", "WA", "WI", "WV", "WY"]

    location_state = location[-2..-1]

    if location[-3] != ','
      return { errors: [location: 'invalid location format'] }
    elsif !state_array.include?(location_state.upcase)
      return { errors: [location: 'invalid state code'] }
    elsif location[0..-4] == ''
      return { errors: [location: 'must include city'] }
    end

    nil
  end

  def quantity_check(quantity)
    if quantity.to_i <=0
      5
    else
      quantity
    end
  end

  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def render_unprocessable_entity_response(exception)
    render json: { 
      error: [exception.record.errors],
      message: "Your request could not be completed"
      }, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { 
      error: [user: 'email or password incorrect', status: '404 Not Found'],
      message: 'Entity not found.'
       }, status: :not_found
  end
end
