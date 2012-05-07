module Zester
  class Response

    attr_accessor :body

    def initialize(response_body, response_type)
      self.body = Hashie::Rash.new(response_body).send(response_type)
    end

    def success?
      !self.response_code.nil? &&  self.response_code == 0
    end

    def error_message
      self.message.text if self.message && self.message.text
    end

    def response_code
      self.message.code.to_i if self.message && self.message.code
    end

    def near_limit?
      self.message && self.message.limit_warning && self.message.limit_warning == "true"
    end

    def message
      self.body.message if self.body.respond_to?(:message)
    end

    def method_missing(method_name, *args)
      if self.body.respond_to?(:response) && self.body.response.respond_to?(method_name)
        self.body.response.send(method_name)
      else
        super
      end
    end

    def respond_to?(method_name)
      if self.body.respond_to?(:response) && self.body.response.respond_to?(method_name)
        true
      else
        super
      end
    end

  end
end
