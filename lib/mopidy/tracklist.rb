module Mopidy
  module Tracklist
    def self.load_playlist(playlist)
      clear
      playlist[:tracks].each do |track|
        add(track)
      end
    end

    def self.tracklist
      json = Mopidy.format_json(1, 'core.tracklist.get_tracks')
      Mopidy.post(json)
    end

    def self.index
      json = Mopidy.format_json(1, 'core.tracklist.index')
      Mopidy.post(json)
    end

    def self.shuffle(start_index, end_index)
      params = { 'start': start_index, 'end': end_index }
      json = Mopidy.format_json(1, 'core.tracklist.shuffle', params)
      Mopidy.post(json)
    end

    def self.tracks
      json = Mopidy.format_json(1, 'core.tracklist.get_tl_tracks')
      Mopidy.post(json)
    end

    def self.add(track)
      json = Mopidy.format_json(1, 'core.tracklist.add', 'uri': track[:uri])
      Mopidy.post(json)
    end

    def self.length
      json = Mopidy.format_json(1, 'core.tracklist.get_length')
      Mopidy.post(json)
    end

    def self.clear
      json = Mopidy.format_json(1, 'core.tracklist.clear')
      Mopidy.post(json)
    end
  end
end
