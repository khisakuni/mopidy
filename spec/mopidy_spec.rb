require 'spec_helper'

describe Mopidy do
  it 'has a version number' do
    expect(Mopidy::VERSION).not_to be nil
  end

  describe '.format_json' do
    context 'without params' do
      it 'formats json' do
        id = 1
        method = 'method'
        target_json =
          { jsonrpc: "2.0", id: 1, method: "method", params: {} }.to_json

        expect(Mopidy.format_json(id, method)).to eq(target_json)
      end
    end

    context 'with params' do
      it 'formats json' do
        id = 1
        method = 'method'
        params = { foo: 'bar' }
        target_json = {
          jsonrpc: "2.0",
          id: 1,
          method: "method",
          params: {
             foo: "bar"
          }
        }.to_json

        expect(Mopidy.format_json(id, method, params)).to eq(target_json)
      end
    end
  end
end
