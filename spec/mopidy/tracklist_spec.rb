require 'spec_helper'

describe Mopidy::Tracklist do
  describe '.load_playlist' do
    let(:playlist) { JSON.parse(fixture('playlist.json')) }
    before do
      stub_post(method: 'core.tracklist.add')
      stub_post(method: 'core.tracklist.clear')
    end
    it 'clears the tracklist' do
      expect(Mopidy::Tracklist).to receive(:clear)

      Mopidy::Tracklist.load_playlist(tracks: [])
    end
    it 'adds tracks into the tracklist' do
      allow(Mopidy::Tracklist).to receive(:clear)
      expect(Mopidy::Tracklist).to receive(:add)

      Mopidy::Tracklist.load_playlist(tracks: [{ uri: 'one' }])
    end
  end
  describe '.tracklist' do
    let(:track_uri) { 'valid_track_uri' }
    before do
      stub_post(
        method: 'core.tracklist.get_tracks',
        fixture_file: 'tracklist.json'
      )
    end
    it 'returns an array of tracks in the tracklist' do
      tracklist = Mopidy::Tracklist.tracklist

      expect(tracklist).to be_an Array
      expect(tracklist.first['uri']).to eq(track_uri)
    end
  end
  describe '.index' do
    let(:expected_index) { 0 }
    before do
      stub_post(
        method: 'core.tracklist.index',
        fixture_file: 'tracklist_index.json'
      )
    end
    it 'returns index of currently playing track' do
      index = Mopidy::Tracklist.index

      expect(index).to eq(expected_index)
    end
  end
  describe '.tracks'
  describe '.add'
  describe '.length'
  describe '.clear'
end
