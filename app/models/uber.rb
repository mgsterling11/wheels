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

  def build_uber(trip)
    # params = {pickup_longitude: trip.origin.longitude, pickup_latitude: trip.origin.latitude, dropoff_longitude: trip.destination.longitude, dropoff_latitude: trip.destination.latitude}
    binding.pry
    url_string = "https://api.uber.com/v1/estimates/price?start_latitude=#{params[pickup_latitude]}&start_longitude=#{params[pickup_longitude]}&end_latitude=#{params[dropoff_latitude]}&end_longitude=#{params[dropoff_longitude]}&server_token=1awe7eeZJLJ0MtUKWAuztdjprfE0siXFI8Bq2XO9"
  end


end

  # def build_url(trip)
  #   params = {pickup_longitude: trip.origin.longitude, pickup_latitude: trip.origin.latitude, dropoff_longitude: trip.destination.longitude, dropoff_latitude: trip.destination.latitude}

  #   url_string = "https://data.cityofnewyork.us/resource/2yzn-sicd.json?$limit=50000&$where="

  #     params.each do | attribute, data |
  #       range1 = data - 0.001
  #       range2 = data + 0.001
  #       url_string += "#{attribute}%20%3E%20#{range1}%20AND%20#{attribute}%20%3C%20#{range2}%20AND%20"
  #     end

  #   url_string.chomp("%20AND%20")

  # end  
