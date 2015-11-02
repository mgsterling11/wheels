
require 'pry'
require 'json'
require 'rest-client'

class TaxiData

  def files
    data = RestClient::Request.execute(method: :get, url:'http://data.cityofnewyork.us/resource/9w7m-hzhe.json')
    test_data = JSON.load(data)
  end

  def populate_databases  
    test_data = files

    test_data.each_with_index do |h, index|
      # CuisineType.create('cuisine_description' => h['cuisine_description'], 'restaurant_id' => index + 1,'id' => index + 1)           
      
    end
  end

  def self.parse
    self.new.populate_databases
  end
end

