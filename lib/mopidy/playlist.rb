module Mopidy
  module Playlist
    def self.playlist(uri)
      json = Mopidy.format_json(1, 'core.playlists.lookup', [uri])
      Mopidy.post(json)
    end

    def self.save_playlist(playlist)
      json = Mopidy.format_json(1, 'core.playlists.save', playlist: playlist)
      Mopidy.post(json)
    end
  end
end
