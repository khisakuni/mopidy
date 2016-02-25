require 'mopidy/version'
require 'mopidy/library'
require 'mopidy/playback'
require 'mopidy/playlist'
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

    def initialize
      @mopidy_url ||= 'http://localhost:6680/mopidy/rpc'
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
    post = HTTParty.post(
      configuration.mopidy_url,
      body: body,
      headers: {
        'Content-Type' => 'application/json'
      }
    )
    result = post.parsed_response['result']
    return {} if result.nil?
    result
  end
end
