require 'spec_helper'

describe Mopidy::Playback do
  describe '.state' do
    context 'while track is playing' do
      before do
        stub_post(JSON.parse(fixture('get_playing_state.json')))
      end

      it 'returns the state' do
        res = Mopidy::Playback.state

        expect(res.body).to eq('playing')
      end
    end

    context 'while track is paused' do
      before do
        stub_post(JSON.parse(fixture('get_paused_state.json')))
      end

      it 'returns the state' do
        res = Mopidy::Playback.state

        expect(res.body).to eq('paused')
      end
    end

    context 'whilte track is stopped' do
      before do
        stub_post(JSON.parse(fixture('get_stopped_state.json')))
      end

      it 'returns the state' do
        res = Mopidy::Playback.state

        expect(res.body).to eq('stopped')
      end
    end
  end
end
