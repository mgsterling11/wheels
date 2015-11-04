class UserTripsController < ApplicationController

  def new
    render 'welcome'
  end

  def create
    @trip = UserTrip.new
    @trip.build_origin(address: params[:address1])
    @trip.build_destination(address: params[:address2])
    @trip.save
    
    # yellow cab search results
    data = TaxiData.new
    yellow_url = data.build_yellow_cab_url(@trip)
    yellow_search_results = data.connection(yellow_url)
    
    # green cab search results
    green_url = data.build_green_cab_url(@trip)
    green_search_results = data.connection(green_url)

    #add yellow and green cab results
    total_results = yellow_search_results.concat(green_search_results)
   
    @cost = data.calculate_fare(total_results)
    @time = data.calculate_time(total_results)

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


