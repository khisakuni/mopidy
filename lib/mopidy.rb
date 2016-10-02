require 'mopidy/version'
require 'mopidy/library'
require 'mopidy/playback'
require 'mopidy/playlist'
require 'mopidy/tracklist'
require 'mopidy/response'
require 'mopidy/http'
require 'json'
require 'httparty'

module Mopidy
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end

  class Configuration
    attr_accessor :mopidy_url
    attr_accessor :http_provider

    def initialize
      @mopidy_url = 'http://localhost:6680/mopidy/rpc'
      @http_provider = HTTParty
    end
  end

  def self.format_json(id, method, params = {})
    {
      'jsonrpc': '2.0',
      'id': id,
      'method': method,
      'params': params
    }.to_json
  end

  def self.post(body)
    headers = { 'Content-Type' => 'application/json' }
    res = Http.post(configuration.mopidy_url, body, headers)
  end
end
