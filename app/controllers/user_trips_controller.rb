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
    taxi_trip = Adapters::CabClient.new
    yellow_cabs = taxi_trip.find_yellow_cabs(@trip)
    green_cabs = taxi_trip.find_green_cabs(@trip)
    total_results = yellow_cabs.concat(green_cabs)

    #get avg cost and time for user trip
    data = TaxiData.new
    @cost = data.calculate_fare(total_results)
    @time = data.calculate_time(total_results)
    url = data.build_url(@trip)
    @search_results = data.connection(url)


# "tpep_dropoff_datetime"=>"2015-02-25T23:51:03.000"
# "tpep_pickup_datetime"=>"2015-02-25T23:38:02.000"

    # uber search results
    uber_trip = Adapters::UberClient.new   
    uber_results = uber_trip.build_uber_url(@trip)
    @uber_ride = uber_trip.format_uber_results(uber_results)

    # lyft search results
    lyft = Lyft.new.build_lyft(@trip)
    @lyft_cost = lyft.cost
    @lyft_time = lyft.time
    
    render 'show'
  end
end


