require 'mopidy/response'

module Mopidy
  class Http
    def self.post(url, body, headers)
      http_provider = Mopidy.configuration.http_provider
      res = http_provider.post(url, body: body, headers: headers)
      Response.new(res)
    end
  end
end
