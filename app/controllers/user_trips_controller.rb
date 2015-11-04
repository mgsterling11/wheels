class UserTripsController < ApplicationController

  def new
    render 'welcome'
  end

  def create
    #create trip
    @trip = UserTrip.new
    @trip.build_origin(address: params[:address1])
    @trip.build_destination(address: params[:address2])
    @trip.save

    #connect to apis to get data
    client = Adapters::CabClient.new
    yellow_cabs = client.find_yellow_cabs(@trip)
    green_cabs = client.find_green_cabs(@trip)

    # add yellow and green cab results
    total_results = yellow_cabs.concat(green_cabs)

    #get avg cost and time for user trip
    data = TaxiData.new
    @cost = data.calculate_fare(yellow_cabs)
    @time = data.calculate_time(yellow_cabs)
    render 'show'
    
  end

# New search => 

end


