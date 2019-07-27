module Zester
  class Client

    include HTTParty
    format :xml
    base_uri "http://www.zillow.com/webservice"

    attr_accessor :zws_id, :http_timeout

    def initialize(zws_id, http_timeout = nil)
      self.zws_id = zws_id
      self.http_timeout = http_timeout
      self.class.default_params "zws-id" => zws_id
    end

    def perform_get(endpoint, params = {})
      http_params = {}
      unless params.empty?
        http_params[:query] = params
      end
      unless self.http_timeout.nil?
        http_params[:timeout] = self.http_timeout
      end
      self.class.get("/#{endpoint}.htm", http_params)
    end

    def property
      @property = Zester::Property.new(self)
    end

    def valuation
      @valuation = Zester::Valuation.new(self)
    end

    def neighborhood
      @neighborhood = Zester::Neighborhood.new(self)
    end

  end
end
