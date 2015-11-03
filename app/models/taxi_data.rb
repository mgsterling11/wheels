require 'json'
require 'rest-client'
require 'time'
require 'date'
require 'time_diff'
require 'pry'

class TaxiData
  binding.pry

  def connection
    data = RestClient::Request.execute(method: :get, url: 'http://data.cityofnewyork.us/resource/2yzn-sicd.json?$limit=5000&$where=pickup_longitude%20%3E%20-74.00111938476563%20AND%20pickup_longitude%20%3C%20-73.98111938476562%20AND%20pickup_latitude%20%3E%2040.75047134399414%20AND%20pickup_latitude%20%3C%2040.77047134399414%20AND%20dropoff_longitude%20%3E%20-74.01748443603516%20AND%20dropoff_longitude%20%3C%20-73.99748443603515%20AND%20dropoff_latitude%20%3E%2040.730955352783205%20AND%20dropoff_latitude%20%3C%2040.7509553527832')
      # => 1000 results: 'http://data.cityofnewyork.us/resource/2yzn-sicd.json?$where%20pickup_longitude%20between%20%25%2773.980430603027044%27%20and%20%25%2773.980430603027644%27%27%20and%20%where=pickup_latitude%20between%20%%2740.761074066161809%27%20and%20%%2740.761074066162409%27%20and%20%where=dropoff_longitude%20between%20%%27-73.976699829101263%27%20and%20%%27-73.976699829101863%27%20and%20%wheredropoff_latitude%20between%20%%2740.733909606933294%27%20and%20%%2740.733909606933*94%27'
    test_data = JSON.load(data)
  end

  def build_url(plong, plat, dlong, dlat)
    pickup_longitude = plong
      plong1 = pickup_longitude - 0.001
      plong2 = pickup_longitude + 0.001
    pickup_latitude = plat
      plat1 = pickup_latitude - 0.001
      plat2 = pickup_latitude + 0.001
    dropoff_longitude = dlong
      dlong1 = dropoff_longitude - 0.001
      dlong2 = dropoff_longitude + 0.001
    dropoff_latitude = dlat
      dlat1 = dropoff_latitude - 0.001
      dlat2 = dropoff_latitude + 0.001

    url_string = "https://data.cityofnewyork.us/resource/2yzn-sicd.json?$limit=50000&$where=pickup_longitude%20%3E%20#{plong1}%20AND%20pickup_longitude%20%3C%20#{plong2}%20AND%20pickup_latitude%20%3E%20#{plat1}%20AND%20pickup_latitude%20%3C%20#{plat2}%20AND%20dropoff_longitude%20%3E%20#{dlong1}%20AND%20dropoff_longitude%20%3C%20#{dlong2}%20AND%20dropoff_latitude%20%3E%20#{dlat1}%20AND%20dropoff_latitude%20%3C%20#{dlat2}"
  end

  def calculate_fare
    parsed_data = connection
    num = parsed_data.map do |hash|
      hash["total_amount"].to_f  
    end  
    result = num.inject{ |sum, el| sum + el }.to_f / num.size
  end
  
  def calculate_time
    parsed_data = connection

    time_differences = parsed_data.map do |hash|
      pickup = DateTime.parse(hash["tpep_pickup_datetime"]) 
      dropoff = DateTime.parse(hash["tpep_dropoff_datetime"])
      diff = Time.diff(dropoff, pickup, '%y, %M, %w, %d and %H %N %S') 
    end

    result = time_differences.map { |time| time[:minute] }
    result.inject{ |sum, el| sum + el }.to_f / result.size
  end
end



