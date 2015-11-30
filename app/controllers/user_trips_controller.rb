class UserTripsController < ApplicationController
    before_action :set_trip, only: [:create]

  def new
    if session[:user_id]
      HistoricalTrip.destroy_all
      @user = User.find(session[:user_id])
      @favorite_trips = @user.user_trips.map {|trip| ["#{trip.origin.address} to #{trip.destination.address}", trip.id]}
    end
    render 'welcome'
  end

  def create
    total_results = cab_results(@trip)
    total_results.map {|trip| HistoricalTrip.create(trip)} #create historical trips
    redirect_to @trip
  end

  def destroy
    UserTrip.destroy(params[:id])    
    redirect_to my_trips_path
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
    render 'taxi_data'
  end

  def subway
    @trip = UserTrip.last
    render 'subway'
  end

  private

  def set_trip
    params[:trip] != "" &&  params[:trip] ? @trip = UserTrip.find(params[:trip]) : @trip = UserTrip.new
    @trip.build_origin(address: params[:address1]) unless @trip.origin
    @trip.build_destination(address: params[:address2]) unless @trip.destination
    @trip.user_id = session[:user_id] if logged_in?
    @trip.save
    @trip
  end

  def cab_results(trip)
    taxi_trip = Adapters::CabClient.new
    total_results = taxi_trip.find_cab_trips(trip)
    binding.pry
    # total_results = yellow_cabs.concat(green_cabs)
    if total_results.count > 0
      return total_results
    else
      @message = "Sorry, there are no records for that trip."
      render 'welcome'
    end
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


