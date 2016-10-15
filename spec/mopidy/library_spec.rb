require 'spec_helper'

describe Mopidy::Library do
  describe '.search' do
    context 'with search results present' do
      context 'given a track title' do
        let(:track_title) { 'Track Title' }

        before do
          stub_post(JSON.parse(fixture('search_track.json')))
        end

        it 'returns an array of matching tracks' do
          res = Mopidy::Library.search_tracks(track_title)

          expect(res.body.first['name'].downcase).to eq(track_title.downcase)
        end
      end

      context 'given an artist name' do
        let(:artist_name) { 'Artist Name' }

        before do
          stub_post(JSON.parse(fixture('search_track.json')))
        end

        it 'returns an array of matching tracks' do
          res = Mopidy::Library.search_tracks(artist_name)

          expect(res.body.first['artists'].first['name']).to eq(artist_name)
        end
      end

      context 'given an album name' do
        let(:album_name) { 'Album Name' }

        before do
          stub_post(JSON.parse(fixture('search_track.json')))
        end

        it 'returns an array of matching tracks' do
          res = Mopidy::Library.search_tracks(album_name)

          expect(res.body.first['album']['name']).to eq(album_name)
        end
      end
    end

    context 'without search result present' do
      let(:no_match) { 'No Match' }
      before do
        stub_post(JSON.parse(fixture('no_search_match.json')))
      end

      it 'returns an empty array' do
        res = Mopidy::Library.search_tracks(no_match)

        expect(res.body).to be_empty
      end
    end
  end

  describe '.lookup' do
    context 'given a valid uri' do
      let(:uri) { 'valid_track_uri' }

      before do
        stub_post(JSON.parse(fixture('look_up_track.json')))
      end

      it 'returns the track' do
        res = Mopidy::Library.lookup(uri)

        expect(res.body['uri']).to eq(uri)
      end
    end

    context 'given an invalid uri' do
      let(:uri) { 'invalid_track_uri' }

      before do
        stub_post(JSON.parse(fixture('look_up_invalid_track.json')))
      end

      it 'returns an empty hash' do
        res = Mopidy::Library.lookup(uri)

        expect(res.body).to eq([])
      end
    end
  end
end
