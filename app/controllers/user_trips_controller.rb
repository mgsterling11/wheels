class UserTripsController < ApplicationController
    before_action :set_trip, only: [:create]

  def new
    @user = User.find(session[:user_id])
    @favorite_trips = @user.user_trips.map {|trip| ["#{trip.origin.address} to #{trip.destination.address}", trip.id]}
    render 'welcome'
  end

  def create
    total_results = cab_results(@trip)
    total_results.map {|trip| HistoricalTrip.create(trip)} #create historical trips
    redirect_to @trip
  end

  def show
    @trip = UserTrip.find(params[:id])
    find_cab_cost(HistoricalTrip.all) # return @cost
    find_cab_time(HistoricalTrip.all) # return @time
    uber_results(@trip) #return @uber_ride
    lyft_results(@trip) #return @lyft
  end

  def taxi_data
    # needs testing
    javascript_include_tag "//www.google.com/jsapi", "chartkick" 
    render 'taxi_data'
  end

  def subway
    @trip = UserTrip.last
    render 'subway'
  end

  private

  def set_trip
    params[:trip] ? @trip = trip.find(params[:trip]) | @trip = UserTrip.new
    @trip.origin ? origin = @trip.origin | origin = params[:address1]
    @trip.destination ? destination = @trip.destination | destination = params[:address2]
    @trip.user_id = session[:user_id] if logged_in?
    @trip.build_origin(address: origin)
    @trip.build_destination(address: destination)
    @trip.save
    @trip
  end

  def cab_results(trip)
    taxi_trip = Adapters::CabClient.new
    yellow_cabs = taxi_trip.find_yellow_cabs(trip)
    green_cabs = taxi_trip.find_green_cabs(trip)
    total_results = yellow_cabs.concat(green_cabs)
    @message = "Sorry, there are no records for that trip." unless total_results
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

  # def generate_google_directions(trip)
  #   google_results = GoogleMap.new   
  #   googe_directions = google_results.build_google(trip)
  #   @google_route = google_results.format_google_results(google_directions)
  # end

  def lyft_results(trip)
    @lyft = Lyft.new.build_lyft(trip) 
  end

end


