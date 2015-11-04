class Uber < ActiveRecord::Base

### JEFF SPOTIFY CONNECTION
# module Adapters
#   class SpotifyConnection
    include HTTParty

    attr_reader :connection

    def initialize
      @connection = self.class
    end


######################### params, server_token ################################
# parameters = {
#     'server_token': 'INSERT_SERVER_TOKEN_HERE',
#     'latitude': 37.775818,
#     'longitude': -122.418028,
# }

# response = requests.get(url, params=parameters)

# data = response.json()
################################################################################




### SEPARATE by /price/start_latitude=xxxxx&start_longitude=xxxx&end_latitude-xxxx&end_longitude-xxxx&server_token=xxxx
## SAMPLE QUERY https://api.uber.com/v1/estimates/price?start_latitude=37.625732&start_longitude=-122.377807&end_latitude=37.785114&end_longitude=-122.406677&server_token=1awe7eeZJLJ0MtUKWAuztdjprfE0siXFI8Bq2XO9

  def query(query = {})
      results = connection.get("https://api.uber.com/v1/estimates/price", {query: query})
      params = {server_token: "&server_token=1awe7eeZJLJ0MtUKWAuztdjprfE0siXFI8Bq2XO9", pickup_longitude: trip.origin.longitude, pickup_latitude: trip.origin.latitude, dropoff_longitude: trip.destination.longitude, dropoff_latitude: trip.destination.latitude}



      
      # s_results = RecursiveOpenStruct.new(results, :recurse_over_arrays => true)
    end
  end
end


### JEFF PARAMS, connects to CONNECTION
# module Adapters
#   class ArtistClient
    def connection
      @connection = Adapters::SpotifyConnection.new
    end

    def find_by_name(name)
      results = connection.query(q: name, type: 'artist')
      artists = results.artists.items
      artist_objects = artists.map do |artist_struct|
        # Artist.find_or_initialize_by(name: )
        # Artist.new(name: artist_struct.name, spotify_id: artist_struct.id)
      end
    end
  end
end







## 1awe7eeZJLJ0MtUKWAuztdjprfE0siXFI8Bq2XO9 <== SERVER TOKEN

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
