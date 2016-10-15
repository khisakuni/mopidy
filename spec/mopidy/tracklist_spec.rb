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

  describe '.tracks' do
    let(:track_uri) { 'valid_track_uri' }

    before do
      stub_post(JSON.parse(fixture('tracklist.json')))
    end

    it 'returns an array of tracks in the tracklist' do
      res = Mopidy::Tracklist.tracks

      expect(res.body.first['uri']).to eq(track_uri)
    end
  end

  describe '.index' do
    let(:expected_index) { 0 }

    before do
      stub_post(JSON.parse(fixture('tracklist_index.json')))
    end

    it 'returns index of currently playing track' do
      res = Mopidy::Tracklist.index

      expect(res.body).to eq(expected_index)
    end
  end

  describe '.tl_tracks'
  describe '.add'
  describe '.length'
  describe '.clear'
end
