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

end
