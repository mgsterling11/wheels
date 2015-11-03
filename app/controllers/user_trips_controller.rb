class UserTripsController < ApplicationController


  def new
    # render 'welcome'

  end

  def create
    @location = Location.new(params)
    @latitude = @location.latitude
    binding.pry
    @longitude = @location.longitude
  end

# New search => 


  def new_trip(argument)
    @trip = TaxiData.new.parse_data(argument)
    @trip.fare
    @trip.averagetime

    if Trip.create_or_find_by(search_params)
      
    else 
      TaxiData.new
    end
  end
end
