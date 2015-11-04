require 'json'
require 'rest-client'
require 'time'
require 'date'
require 'time_diff'
require 'pry'

class TaxiData

  # MOVE TO ADAPTER??
  def connection(url_string)
    data = RestClient::Request.execute(method: :get, url: url_string)
    test_data = JSON.load(data)
  end

  def build_url(trip)
    params = {pickup_longitude: trip.origin.longitude, pickup_latitude: trip.origin.latitude, dropoff_longitude: trip.destination.longitude, dropoff_latitude: trip.destination.latitude}

    url_string = "https://data.cityofnewyork.us/resource/2yzn-sicd.json?$limit=50000&$where="

      params.each do | attribute, data |
        range1 = data - 0.001
        range2 = data + 0.001
        url_string += "#{attribute}%20%3E%20#{range1}%20AND%20#{attribute}%20%3C%20#{range2}%20AND%20"
      end

    url_string.chomp("%20AND%20")

  end  

# BUILD GREEN URL
  def build_green_url(trip)
    params = {pickup_longitude: trip.origin.longitude, pickup_latitude: trip.origin.latitude, dropoff_longitude: trip.destination.longitude, dropoff_latitude: trip.destination.latitude}

    url_string = "https://data.cityofnewyork.us/resource/utt9-dvgj.json?$limit=50000&$where="

      params.each do | attribute, data |
        range1 = data - 0.001
        range2 = data + 0.001
        url_string += "#{attribute}%20%3E%20#{range1}%20AND%20#{attribute}%20%3C%20#{range2}%20AND%20"
      end

    url_string.chomp("%20AND%20")

  end  

  # -------END ADAPTER


  # KEEP IN TAXI DATA CLASS
  def calculate_fare(results)
   
    num = results.map do |hash|
      hash["total_amount"].to_f  
    end  
    average = num.inject{ |sum, el| sum + el }.to_f / num.size
  end
  
  def calculate_time(results)
    time_differences = results.map do |hash|
      pickup = DateTime.parse(hash["tpep_pickup_datetime"]) 
      dropoff = DateTime.parse(hash["tpep_dropoff_datetime"])
      diff = Time.diff(dropoff, pickup, '%y, %M, %w, %d and %H %N %S') 
    end

    result = time_differences.map { |time| time[:minute] }
    result.inject{ |sum, el| sum + el }.to_f / result.size
  end
end

# OLD STRING CONSTRUCTION
# ----------------------------------
# def build_url(plong, plat, dlong, dlat)
  #   pickup_longitude = plong
  #     plong1 = pickup_longitude - 0.001
  #     plong2 = pickup_longitude + 0.001
  #   pickup_latitude = plat
  #     plat1 = pickup_latitude - 0.001
  #     plat2 = pickup_latitude + 0.001
  #   dropoff_longitude = dlong
  #     dlong1 = dropoff_longitude - 0.001
  #     dlong2 = dropoff_longitude + 0.001
  #   dropoff_latitude = dlat
  #     dlat1 = dropoff_latitude - 0.001
  #     dlat2 = dropoff_latitude + 0.001

  #   url_string = "https://data.cityofnewyork.us/resource/2yzn-sicd.json?$limit=50000&$where=pickup_longitude%20%3E%20#{plong1}%20AND%20pickup_longitude%20%3C%20#{plong2}%20AND%20pickup_latitude%20%3E%20#{plat1}%20AND%20pickup_latitude%20%3C%20#{plat2}%20AND%20dropoff_longitude%20%3E%20#{dlong1}%20AND%20dropoff_longitude%20%3C%20#{dlong2}%20AND%20dropoff_latitude%20%3E%20#{dlat1}%20AND%20dropoff_latitude%20%3C%20#{dlat2}"
  #   data = RestClient::Request.execute(method: :get, url: url_string)
  #   test_data = JSON.load(data)
  # end

