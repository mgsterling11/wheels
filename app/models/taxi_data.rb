require 'json'
require 'rest-client'

class TaxiData

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
    # url_string = "https://data.cityofnewyork.us/resource/2yzn-sicd.json?$limit=5000&$where=pickup_longitude%20%3E%20-74.00111938476563%20AND%20pickup_longitude%20%3C%20-73.98111938476562%20AND%20pickup_latitude%20%3E%2040.75047134399414%20AND%20pickup_latitude%20%3C%2040.77047134399414%20AND%20dropoff_longitude%20%3E%20-74.01748443603516%20AND%20dropoff_longitude%20%3C%20-73.99748443603515%20AND%20dropoff_latitude%20%3E%2040.730955352783205%20AND%20dropoff_latitude%20%3C%2040.7509553527832

  end
end
# %3C = <
# %3E = >



# def build_url(search_params)
# #    search_params = { 'Pickup_longitude' => '', "Pickup_latitude" => '', "Dropoff_longitude" => '', "Dropoff_latitude" => '', 
# #                     pickup_datetime" => 'tpep_pickup_datetime=2015-02-22T23:36:57.000' }
# # This cannot include date/time because it is a different format
# # how do we get days of the week?? Should we just use the Google API instead?
    
#     string = 'http://data.cityofnewyork.us/resource/2yzn-sicd.json?$where='
#       search_params.each do |attribute, data|
#         range1 = data - 0.000000000003000
#         range2 = data + 0.000000000003000
#         string += "#{attribute}%20between%20%#{range1}%20and%20%#{range2}"
#     end
#     #convert time to now
#     t = 
#     t.strftime("%I:%M%p")      
#   end

#   def search_results(url_string)
#     data = RestClient::Request.execute(method: :get, url: url_string)
#     test_data = JSON.load(data)
#   end

# end


# pickup_longitude = -73.980430603027344
# plong1 = pickup_longitude - 0.000000000003000
# plong2 = pickup_longitude + 0.000000000003000
# "?$where=picup_logitutde%20between%20%#{plong1}%20and%20%#{plong2}"


# #pickup-datetime
# 'https://data.cityofnewyork.us/resource/2yzn-sicd.json?tpep_pickup_datetime=2015-02-22T23:36:57.000'
# #pickup-longitude
# 'https://data.cityofnewyork.us/resource/2yzn-sicd.json?pickup_longitude=-73.980430603027344'
# #pickup-latitude
# 'https://data.cityofnewyork.us/resource/2yzn-sicd.json?pickup_latitude=40.761074066162109'
# #dropoff-longitude
# https://data.cityofnewyork.us/resource/2yzn-sicd.json?dropoff_longitude=-73.972183227539063
# #dropoff-latitude
# https://data.cityofnewyork.us/resource/2yzn-sicd.json?dropoff_latitude=40.751735687255859


# string = "https://data.cityofnewyork.us/resource/2np7-5jsg.json?$where=pickup_longitude%20%3E%20#{plong1}%20AND%20pickup_longitude%20%3C%20#{plong2}
#   %20AND%20pickup_latitude%20%3E%20#{plat1}
#   %20AND%20pickup_latitude%20%3C%20#{plat2}
#   %20AND%20dropoff_longitude%20%3E%20#{dlong1}
#   %20AND%20dropoff_longitude%20%3C%20#{dlong2}
#   %20AND%20dropoff_latitude%20%3E%20#{dlat1}
#   %20AND%20dropoff_latitude%20%3C%20#{dlat2}"


#   search_params = {'pickup_longitude' => 73.980430603027344, 'pickup_latitude' => 40.761074066162109 }

# string = "http://data.cityofnewyork.us/resource/2yzn-sicd.json?$where=pickup_longitude%20between%20%'73.980430603027044'%20and%20%'73.980430603027644'"
# string += "%20and%20%where=pickup_latitude%20between%20%'40.761074066161809'%20and%20%'40.761074066162409'"
# string += "%20and%20%where=dropoff_longitude%20between%20%'-73.976699829101263'%20and%20%'-73.976699829101863'"
# string += "%20and%20%where=dropoff_latitude%20between%20%'40.733909606933294'%20and%20%'40.733909606933*94'"


# string = "http://data.cityofnewyork.us/resource/2yzn-sicd.json?$where=pickup_longitude%20between%20%'73.9804306030'%20and%20%'73.9804306030'%20and%20%where=pickup_latitude%20between%20%'40.7610740661'%20and%20%'40.7610740661'%20and%20%where=dropoff_longitude%20between%20%'-73.976699829101263'%20and%20%'-73.976699829101863'%20and%20%where=dropoff_latitude%20between%20%'40.733909606933294'%20and%20%'40.733909606933*94'"
