module Zester
  class Resource

    attr_accessor :client

    def initialize(client)
      self.client = client
    end

    def get_results(endpoint, resource_type, params = {})
      Response.new(self.client.perform_get(endpoint, params), resource_type)
    end

  end
end
