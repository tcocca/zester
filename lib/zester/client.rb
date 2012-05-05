module Zester
  class Client

    include HTTParty
    format :xml
    base_uri "http://www.zillow.com/webservice"

    attr_accessor :zws_id

    def initialize(zws_id)
      self.zws_id = zws_id
      self.class.default_params "zws-id" => zws_id
    end

    def perform_get(endpoint, params = {})
      self.class.get("/#{endpoint}.htm", :query => params)
    end

    def property
      @property = Zester::Property.new(self)
    end

    def mortgage
      @mortgage = Zester::Mortgage.new(self)
    end

    def valuation
      @valuation = Zester::Valuation.new(self)
    end

    def neighborhood
      @neighborhood = Zester::Neighborhood.new(self)
    end

  end
end
