require 'pry'
class Uber 

################ working code ###############
# url_string = "https://api.uber.com/v1/estimates/price?start_latitude=#{params[:pickup_latitude]}&start_longitude=#{params[:pickup_longitude]}&end_latitude=#{params[:dropoff_latitude]}&end_longitude=#{params[:dropoff_longitude]}&server_token=1awe7eeZJLJ0MtUKWAuztdjprfE0siXFI8Bq2XO9"
# params = {pickup_latitude: "40.7599157",  pickup_longitude: "-73.9911492", dropoff_latitude: "40.705329", dropoff_longitude: "-74.0139696"}
################ working code ###############

 
 
 ## SAMPLE QUERY https://api.uber.com/v1/estimates/price?start_latitude=37.625732&start_longitude=-122.377807&end_latitude=37.785114&end_longitude=-122.406677&server_token=1awe7eeZJLJ0MtUKWAuztdjprfE0siXFI8Bq2XO9
  def connection(url_string)
    data = RestClient::Request.execute(method: :get, url: url_string)
    test_data = JSON.load(data)
  end

  def build_uber_url(trip)
    params = {pickup_latitude: trip.origin.latitude, pickup_longitude: trip.origin.longitude, dropoff_longitude: trip.destination.longitude, dropoff_latitude: trip.destination.latitude}
    # binding.pry
    url_string = "https://api.uber.com/v1/estimates/price?start_latitude=#{params[:pickup_latitude]}&start_longitude=#{params[:pickup_longitude]}&end_latitude=#{params[:dropoff_latitude]}&end_longitude=#{params[:dropoff_longitude]}&server_token=1awe7eeZJLJ0MtUKWAuztdjprfE0siXFI8Bq2XO9"
  end

  def return_uber_results(results)
    uber_hash = results["prices"].map do |hash|
      {"localized_display_name" => hash["localized_display_name"],
      "duration" => (hash["duration"] / 60),
      "estimate" => hash["estimate"]}
    end  
    uber_hash
  end

 #  [{"localized_display_name"=>"uberX", "duration"=>18, "estimate"=>"$13-18"},
 # {"localized_display_name"=>"uberXL", "duration"=>18, "estimate"=>"$20-27"},
 # {"localized_display_name"=>"uberFAMILY",
 #  "duration"=>18,
 #  "estimate"=>"$23-28"},
 # {"localized_display_name"=>"UberBLACK", "duration"=>18, "estimate"=>"$25-32"},
 # {"localized_display_name"=>"UberSUV", "duration"=>18, "estimate"=>"$36-44"},
 # {"localized_display_name"=>"uberT", "duration"=>18, "estimate"=>"Metered"},
 # {"localized_display_name"=>"Yellow WAV", "duration"=>18, "estimate"=>"$0"}]
  
end