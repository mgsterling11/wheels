
require 'pry'
require 'json'
require 'rest-client'
require 'time'

class TaxiData

binding.pry

  def files
    data = RestClient::Request.execute(method: :get, url:'http://data.cityofnewyork.us/resource/2yzn-sicd.json?$where%20pickup_longitude%20between%20%25%2773.980430603027044%27%20and%20%25%2773.980430603027644%27%27%20and%20%where=pickup_latitude%20between%20%%2740.761074066161809%27%20and%20%%2740.761074066162409%27%20and%20%where=dropoff_longitude%20between%20%%27-73.976699829101263%27%20and%20%%27-73.976699829101863%27%20and%20%wheredropoff_latitude%20between%20%%2740.733909606933294%27%20and%20%%2740.733909606933*94%27')
    test_data = JSON.load(data)
    
    first_ten = test_data[0..9]

    num = first_ten.map do |hash|
      hash["total_amount"].to_f  
    end  
    result = num.inject{ |sum, el| sum + el }.to_f / num.size
# binding.pry
  end


  def calculate_time
    data = RestClient::Request.execute(method: :get, url:'http://data.cityofnewyork.us/resource/2yzn-sicd.json?$where%20pickup_longitude%20between%20%25%2773.980430603027044%27%20and%20%25%2773.980430603027644%27%27%20and%20%where=pickup_latitude%20between%20%%2740.761074066161809%27%20and%20%%2740.761074066162409%27%20and%20%where=dropoff_longitude%20between%20%%27-73.976699829101263%27%20and%20%%27-73.976699829101863%27%20and%20%wheredropoff_latitude%20between%20%%2740.733909606933294%27%20and%20%%2740.733909606933*94%27')
    test_data = JSON.load(data)
    
    first_ten = test_data[0..9]

    pickup = first_ten.map do |hash|
      Time.parse(hash["tpep_pickup_datetime"]) 
    end

    dropoff = first_ten.map do |hash|
      Time.parse(hash["tpep_dropoff_datetime"])
    end
      pickup[-11..-9]

      dropoff[-14..-1] - pick[-14..-1]

      ##pickup = hash["tpep_pickup_datetime"][-12..-1].to_i
      ##dropoff = hash["tpep_pickup_datetime"][-12..-1]to_i
      time = dropoff - pickup
    end  
    result = num.inject{ |sum, el| sum + el }.to_f / num.size
  end
end
2015-03-06 17:13:27 -0500



# "tpep_dropoff_datetime"=>"2015-04-16T10:29:28.000",
#   "tpep_pickup_datetime"=>"2015-04-16T10:04:32.000",


#   def self.parse
#     self.new.populate_databases
#   end
# end



  
