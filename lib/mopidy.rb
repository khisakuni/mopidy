require "mopidy/version"
require 'mopidy/library'

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
end
