require 'json'
require 'rest-client'
require 'time'
require 'date'
require 'time_diff'
require 'pry'

class TaxiData

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



