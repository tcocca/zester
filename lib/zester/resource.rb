module Zester
  class Resource

    attr_accessor :client

    def initialize(client)
      self.client = client
    end

    def get_results(endpoint, resource_type, params = {})
      begin
        Response.new(self.client.perform_get(endpoint, params), resource_type)
      rescue Timeout::Error, Exception
        Response.new({resource_type => {:message => {:code => "3", :text => "Web services are currently unavailable"}}}, resource_type)
      end
    end

  end
end
