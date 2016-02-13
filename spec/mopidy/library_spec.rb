require 'spec_helper'
require 'pry'

describe Mopidy::Library do
  describe '.search_tracks' do
    context 'with search results present' do
      context 'given a track title' do
        let(:track_title) { 'Track Title' }
        before do
          stub_post(
            'core.library.search',
            [{ 'any': track_title }],
            'search_track.json'
          )
        end
        it 'returns an array of matching tracks' do
          tracks = Mopidy::Library.search_tracks(track_title)

          expect(tracks).to be_an Array
          expect(tracks.first['name'].downcase).to eq(track_title.downcase)
        end
      end
      context 'given an artist name' do
        let(:artist_name) { 'Artist Name' }
        before do
          stub_post(
            'core.library.search',
            [{ 'any': artist_name }],
            'search_track.json'
          )
        end
        it 'returns an array of matching tracks' do
          tracks = Mopidy::Library.search_tracks(artist_name)

          expect(tracks).to be_an Array
          expect(tracks.first['artists'].first['name']).to eq(artist_name)
        end
      end
      context 'given an album name' do
        let(:album_name) { 'Album Name' }
        before do
          stub_post(
            'core.library.search',
            [{ 'any': album_name }],
            'search_track.json'
          )
        end
        it 'returns an array of matching tracks' do
          tracks = Mopidy::Library.search_tracks(album_name)

          expect(tracks).to be_an Array
          expect(tracks.first['album']['name']).to eq(album_name)
        end
      end
    end
    context 'without search result present' do
      let(:no_match) { 'No Match' }
      before do
        stub_post(
          'core.library.search',
          [{ 'any': no_match}],
          'no_search_match.json'
        )
      end
      it 'returns an empty array' do
        tracks = Mopidy::Library.search_tracks(no_match)

        expect(tracks).to be_an Array
        expect(tracks).to be_empty
      end
    end
  end
  describe '.get_track' do
    context 'given a valid uri' do
      let(:uri) { 'valid_track_uri' }
      before do
        stub_post(
          'core.library.lookup',
          { 'uri': uri },
          'look_up_track.json'
        )
      end
      it 'returns the track' do
        track = Mopidy::Library.get_track(uri)

        expect(track['uri']).to eq(uri)
      end
    end
    context 'given an invalid uri' do
      let(:uri) { 'invalid_track_uri' }
      before do
        stub_post(
          'core.library.lookup',
          { 'uri': uri },
          'look_up_invalid_track.json'
        )
      end
      it 'returns an empty hash' do
        track = Mopidy::Library.get_track(uri)

        expect(track).to eq({})
      end
    end
  end
end
