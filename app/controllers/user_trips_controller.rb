class UserTripsController < ApplicationController

  def new
    render 'welcome'
  end

  def create
    @trip = UserTrip.new
    @trip.build_origin(address: params[:address1])
    @trip.build_destination(address: params[:address2])
    @trip.save
  
    data = TaxiData.new
    url = data.build_url(@trip)
    search_results = data.connection(url)
   
    @cost = data.calculate_fare(search_results)
    @time = data.calculate_time(search_results)
    render 'show'
    
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


