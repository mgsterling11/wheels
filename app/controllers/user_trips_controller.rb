class UserTripsController < ApplicationController


  def new
    render 'welcome'

  end

  def create
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
