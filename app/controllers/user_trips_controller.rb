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
    @search_results = data.connection(url)

    


# "tpep_dropoff_datetime"=>"2015-02-25T23:51:03.000"
# "tpep_pickup_datetime"=>"2015-02-25T23:38:02.000"
   
    @cost = data.calculate_fare(@search_results)
    @time = data.calculate_time(@search_results)

    lyft = Lyft.new(@trip)
    @lyft_cost = lyft.cost
    @lyft_time = lyft.time
    
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


