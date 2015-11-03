
require 'pry'
require 'json'
require 'rest-client'
require 'time'
require 'date'
require 'time_diff'

class TaxiData



  def calculate_fare
    data = RestClient::Request.execute(method: :get, url:'http://data.cityofnewyork.us/resource/2yzn-sicd.json?$where%20pickup_longitude%20between%20%25%2773.980430603027044%27%20and%20%25%2773.980430603027644%27%27%20and%20%where=pickup_latitude%20between%20%%2740.761074066161809%27%20and%20%%2740.761074066162409%27%20and%20%where=dropoff_longitude%20between%20%%27-73.976699829101263%27%20and%20%%27-73.976699829101863%27%20and%20%wheredropoff_latitude%20between%20%%2740.733909606933294%27%20and%20%%2740.733909606933*94%27')
    test_data = JSON.load(data)
    
    first_ten = test_data[0..9]

    num = first_ten.map do |hash|
      hash["total_amount"].to_f  
    end  
    result = num.inject{ |sum, el| sum + el }.to_f / num.size
  end


  def calculate_time
    data = RestClient::Request.execute(method: :get, url:'http://data.cityofnewyork.us/resource/2yzn-sicd.json?$where%20pickup_longitude%20between%20%25%2773.980430603027044%27%20and%20%25%2773.980430603027644%27%27%20and%20%where=pickup_latitude%20between%20%%2740.761074066161809%27%20and%20%%2740.761074066162409%27%20and%20%where=dropoff_longitude%20between%20%%27-73.976699829101263%27%20and%20%%27-73.976699829101863%27%20and%20%wheredropoff_latitude%20between%20%%2740.733909606933294%27%20and%20%%2740.733909606933*94%27')
    test_data = JSON.load(data)
    
    first_ten = test_data[0..9] 

    time_differences = first_ten.map do |hash|
      pickup = DateTime.parse(hash["tpep_pickup_datetime"]) 
      dropoff = DateTime.parse(hash["tpep_dropoff_datetime"])
      diff = Time.diff(dropoff, pickup, '%y, %M, %w, %d and %H %N %S') 
    end

    result = time_differences.map { |time| time[:minute] }
    result.inject{ |sum, el| sum + el }.to_f / result.size
  end
end




  
