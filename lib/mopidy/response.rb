module Mopidy
  class Response
    def initialize(response)
      @response = response
    end

    def status
      @response.code
    end

    def body
      has_error?(@response) ? parse_error(@response) : parse_response(@response)
    end

    private

    def has_error?(response)
      response.parsed_response['result'].nil?
    end

    def parse_response(response)
      response.parsed_response['result']
    end

    def parse_error(response)
      response.parsed_response['error']
    end
  end
end
