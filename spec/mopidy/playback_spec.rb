require 'spec_helper'
require 'pry'

describe Mopidy::Playback do
  describe '.state' do
    context 'while track is playing' do
      before do
        stub_post('core.playback.get_state', 'get_playing_state.json')
      end
      it 'returns the state' do
        state = Mopidy::Playback.state

        expect(state).to eq('playing')
      end
    end
    context 'while track is paused' do
      before do
        stub_post('core.playback.get_state', 'get_paused_state.json')
      end
      it 'returns the state' do
        state = Mopidy::Playback.state

        expect(state).to eq('paused')
      end
    end
    context 'whilte track is stopped' do
      before do
        stub_post('core.playback.get_state', 'get_stopped_state.json')
      end
      it 'returns the state' do
        state = Mopidy::Playback.state

        expect(state).to eq('stopped')
      end
    end
  end
end
