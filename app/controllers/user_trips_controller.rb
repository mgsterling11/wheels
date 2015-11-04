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
    total_results = yellow_cabs.concat(green_cabs)

    #get avg cost and time for user trip
    data = TaxiData.new
    @cost = data.calculate_fare(total_results)
    @time = data.calculate_time(total_results)


    # uber search results
    uber_trip = Uber.new
    uber_url = uber_trip.build_uber_url(@trip)
    uber_results = uber_trip.connection(uber_url)
    @uber_rides = uber_trip.return_uber_results(uber_results)


    lyft = Lyft.new(@trip)
    @lyft_cost = lyft.cost
    @lyft_time = lyft.time
    

    render 'show'
    
  end

end


