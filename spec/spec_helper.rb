$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'mopidy'
require 'webmock'
require 'pry'

WebMock.disable_net_connect!

Mopidy.configure do |config|
  config.mopidy_url = 'http://mopidyurl:3000'
end

def stub_post(method:, params: {}, fixture_file: nil)
  if fixture_file.nil?
    return stub_post_without_fixture(method, params)
  end
  WebMock.stub_request(:post, Mopidy.configuration.mopidy_url)
    .with(body: json(method, params), headers: { 'Content-Type': 'application/json' })
    .to_return(
      body: fixture(fixture_file),
      headers: {
        content_type: 'application/json; charset=utf-8'
      }
    )
end

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.read(fixture_path + '/' + file)
end

private

def stub_post_without_fixture(method, params)
  WebMock.stub_request(:post, Mopidy.configuration.mopidy_url)
    .with(body: json(method, params), headers: { 'Content-Type': 'application/json' })
end


def json(method, params)
  {
    'jsonrpc': '2.0',
    'id': 1,
    'method': method,
    'params': params
  }.to_json
end
