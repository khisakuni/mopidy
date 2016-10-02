$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mopidy'
require 'webmock'
require 'pry'
require 'mocks/mock_http_provider'

WebMock.disable_net_connect!

Mopidy.configure do |config|
  config.mopidy_url = 'http://mopidyurl:3000'
end

def stub_post(body, status_code = 200)
  MockHttpProvider.configure do |config|
    config.response_body = body
    config.status_code = status_code
  end

  Mopidy.configure do |config|
    config.http_provider = MockHttpProvider
  end
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.read(fixture_path + '/' + file)
end

private

def json(method, params)
  {
    'jsonrpc': '2.0',
    'id': 1,
    'method': method,
    'params': params
  }.to_json
end
