require 'json'
require 'rest-client'
require 'pry'

module Adapters
  class TaxiDataConnection 
  include HTTParty    

    attr_reader :connection

    # def initialize
    #   @connection = self.class
    # end

    def get_data(url)
      data = RestClient::Request.execute(method: :get, url: url)
      test_data = JSON.load(data)
    end
  end
end
