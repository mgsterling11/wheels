class UserTripsController < ApplicationController


  def new
    render 'welcome'
  end

  def create
    @origin = Origin.find_or_create_by(address: params[:address1])
    @destination = Destination.find_or_create_by(address: params[:address2])
    ride = TaxiData.new
    search_results = ride.build_url(@origin.longitude, @origin.latitude, @destination.longitude, @destination.latitude)
    @cost = ride.calculate_fare(search_results)
    @time = ride.calculate_time(search_results)
    render 'show'
    # @search_results = Search.for(params[:address1, :address2])
    # @location = Location.new(params)
    # @latitude = @location.latitude
    # binding.pry
    # @longitude = @location.longitude
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


