require 'spec_helper'

describe Mopidy::Playlist do
  let(:playlist_uri) { 'valid_playlist_uri' }

  describe '.as_list'do
    before do
      stub_post(JSON.parse(fixture('playlists_as_list.json')))
    end

    it 'lists available playlists' do
      res = Mopidy::Playlist.as_list

      expect(res.body.size).to eq(2)
    end
  end

  describe '.lookup' do
    let(:playlist_name) { 'Playlist Name' }
    let(:track_name) { 'Track Name' }
    let(:track_uri) { 'valid_track_uri' }

    context 'given a valid uri' do
      before do
        stub_post(JSON.parse(fixture('playlist.json')))
      end

      it 'gets the playlist' do
        res = Mopidy::Playlist.lookup(playlist_uri)

        expect(res.body['name']).to eq(playlist_name)
        expect(res.body['uri']).to eq(playlist_uri)
      end

      it 'gets the tracks in the playlist' do
        res = Mopidy::Playlist.lookup(playlist_uri)

        expect(res.body['tracks'].first['name']).to eq(track_name)
        expect(res.body['tracks'].first['uri']).to eq(track_uri)
      end
    end
  end

  describe '.save' do
    context 'given a valid playlist object' do
      let(:playlist) { mock_playlist(playlist_uri) }
      let(:new_track) do
        {
          __model__: 'Track',
          name: 'New Track',
          uri: 'new_track_uri'
        }
      end
      let(:target_playlist) do
        playlist['tracks'] << new_track
        playlist
      end

      before do
        stub_post(JSON.parse(fixture('save_playlist.json')))
      end

      it 'saves the playlist' do
        res = Mopidy::Playlist.save(target_playlist)

        expect(res.body['tracks'].length).to eq(target_playlist['tracks'].length)
        expect(res.body['tracks'].last[:name]).to eq(new_track[:name])
        expect(res.body['tracks'].last[:uri]).to eq(new_track[:uri])
      end
    end
  end

  def mock_playlist(playlist_uri)
    stub_post(JSON.parse(fixture('playlist.json')))
    res = Mopidy::Playlist.lookup(playlist_uri)
    res.body
  end
end
