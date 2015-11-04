require 'json'
require 'rest-client'


module Adapters
  class DataConnection   

    attr_reader :query

    def query(url_string)
      data = RestClient::Request.execute(method: :get, url: url_string)
      test_data = JSON.load(data)
    end

  end  
end  

