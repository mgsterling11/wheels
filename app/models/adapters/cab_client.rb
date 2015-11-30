module Adapters
  class CabClient

    def connection
      @connection = Adapters::DataConnection.new
    end

    def find_cab_trips(trip)
      url_fragment = ["2yzn-sicd", "utt9-dvgj"]
      a = url_fragment.map do |fragment|
        url = build_cab_url(trip, fragment)
        conn = connection.query(url)
      end.flatten
    end

    # def find_green_cabs(trip)
    #   url = build_green_cab_url(trip)
    #   connection.query(url)
    # end

    def build_cab_url(trip, fragment)
      params = {pickup_longitude: trip.origin.longitude, pickup_latitude: trip.origin.latitude, dropoff_longitude: trip.destination.longitude, dropoff_latitude: trip.destination.latitude}

      url_string = "https://data.cityofnewyork.us/resource/#{fragment}.json?$limit=50000&$where="
        params.each do | attribute, data |
          range1 = data - 0.001
          range2 = data + 0.001
          url_string += "#{attribute}%20%3E%20#{range1}%20AND%20#{attribute}%20%3C%20#{range2}%20AND%20"
        end
      url_string.chomp("%20AND%20")
    end 

    #  def build_green_cab_url(trip)
    #   params = {pickup_longitude: trip.origin.longitude, pickup_latitude: trip.origin.latitude, dropoff_longitude: trip.destination.longitude, dropoff_latitude: trip.destination.latitude}

    #   url_string = "https://data.cityofnewyork.us/resource/utt9-dvgj.json?$limit=50000&$where="

    #     params.each do | attribute, data |
    #       range1 = data - 0.001
    #       range2 = data + 0.001
    #       url_string += "#{attribute}%20%3E%20#{range1}%20AND%20#{attribute}%20%3C%20#{range2}%20AND%20"
    #     end

    #   url_string.chomp("%20AND%20")

    # end

  end
end