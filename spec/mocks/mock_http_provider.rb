class MockHttpProvider
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end

  class Configuration
    attr_accessor :response_body
    attr_accessor :status_code
  end

  def self.post(url, body:, headers:)
    OpenStruct.new(
      parsed_response: configuration.response_body,
      code: configuration.status_code
    )
  end
end
