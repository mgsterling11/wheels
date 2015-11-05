class UserTripsController < ApplicationController
    before_action :set_trip, only: [:create]

  def new
    render 'welcome'
  end

  def create
    total_results = cab_results(@trip)
    find_cab_cost(total_results) # return @cost
    find_cab_time(total_results) # return @time
    uber_results(@trip) #return @uber_ride
    lyft_results(@trip) #return @lyft
    #create historical trips
    total_results.map {|trip| HistoricalTrip.create(trip)} 
    # "tpep_dropoff_datetime"=>"2015-02-25T23:51:03.000"
    # "tpep_pickup_datetime"=>"2015-02-25T23:38:02.000"
    render 'show'
  end

  private

  def set_trip
    @trip = UserTrip.new
    @trip.user_id = session[:user_id] if logged_in?
    @trip.build_origin(address: params[:address1])
    @trip.build_destination(address: params[:address2])
    @trip.save
    @trip
  end

  def cab_results(trip)
    taxi_trip = Adapters::CabClient.new
    yellow_cabs = taxi_trip.find_yellow_cabs(trip)
    green_cabs = taxi_trip.find_green_cabs(trip)
    total_results = yellow_cabs.concat(green_cabs)
  end

  def find_cab_cost(total_results)
    @cost = TaxiData.new.calculate_fare(total_results)
  end

  def find_cab_time(total_results)
    @time = TaxiData.new.calculate_time(total_results)
  end

  def uber_results(trip)
    uber_trip = Adapters::UberClient.new   
    uber_results = uber_trip.build_uber_url(trip)
    @uber_ride = uber_trip.format_uber_results(uber_results)
  end

  def lyft_results(trip)
    @lyft = Lyft.new.build_lyft(trip) 
  end

end


