require 'spec_helper'

describe Mopidy::Playlist do
  let(:playlist_uri) { 'valid_playlist_uri' }

  describe '.as_list'do
    before do
      stub_post(
        method: 'core.playlists.as_list',
        fixture_file: 'playlists_as_list.json'
      )
    end

    it 'lists available playlists' do
      playlists = Mopidy::Playlist.as_list

      expect(playlists.size).to eq(2)
    end
  end

  describe '.playlist' do
    let(:playlist_name) { 'Playlist Name' }
    let(:track_name) { 'Track Name' }
    let(:track_uri) { 'valid_track_uri' }
    context 'given a valid uri' do
      before do
        stub_post(
          method: 'core.playlists.lookup',
          params: [playlist_uri],
          fixture_file: 'playlist.json'
        )
      end
      it 'gets the playlist' do
        playlist = Mopidy::Playlist.playlist(playlist_uri)

        expect(playlist['name']).to eq(playlist_name)
        expect(playlist['uri']).to eq(playlist_uri)
      end
      it 'gets the tracks in the playlist' do
        playlist = Mopidy::Playlist.playlist(playlist_uri)

        expect(playlist['tracks']).to be_an Array
        expect(playlist['tracks'].first['name']).to eq(track_name)
        expect(playlist['tracks'].first['uri']).to eq(track_uri)
      end
    end
  end

  describe '.save_playlist' do
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
        stub_post(
          method: 'core.playlists.save',
          params: { playlist: target_playlist },
          fixture_file: 'save_playlist.json'
        )
      end

      it 'saves the playlist' do
        saved_playlist = Mopidy::Playlist.save_playlist(target_playlist)

        expect(saved_playlist['tracks'].length).to eq(target_playlist['tracks'].length)
        expect(saved_playlist['tracks'].last['name']).to eq(new_track[:name])
        expect(saved_playlist['tracks'].last['uri']).to eq(new_track[:uri])
      end
    end
  end

  def mock_playlist(playlist_uri)
    stub_post(
      method: 'core.playlists.lookup',
      params: [playlist_uri],
      fixture_file: 'playlist.json'
    )
    Mopidy::Playlist.playlist(playlist_uri)
  end
end
