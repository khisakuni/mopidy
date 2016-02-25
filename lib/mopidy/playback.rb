module Mopidy
  module Playback
    def self.play(tracklist_track_id = nil)
      params = { 'tlid': tracklist_track_id }
      json = Mopidy.format_json(1, 'core.playback.play', params)
      Mopidy.post(json)
    end

    def self.stop
      json = Mopidy.format_json(1, 'core.playback.stop')
      Mopidy.post(json)
    end

    def self.pause
      json = Mopidy.format_json(1, 'core.playback.pause')
      Mopidy.post(json)
    end

    def self.resume
      json = Mopidy.format_json(1, 'core.playback.resume')
      Mopidy.post(json)
    end

    def self.state
      json = Mopidy.format_json(1, 'core.playback.get_state')
      Mopidy.post(json)
    end

    def self.time_position
      json = Mopidy.format_json(1, 'core.playback.get_time_position')
      Mopidy.post(json)
    end

    def self.seek(time_position)
      params = { 'time_position': time_position }
      json = Mopidy.format_json(1, 'core.playback.seek', params)
      Mopidy.post(json)
    end

    def self.current_track
      json = Mopidy.format_json(1, 'core.playback.get_current_track')
      Mopidy.post(json)
    end

    def self.next
      json = Mopidy.format_json(1, 'core.playback.next')
      Mopidy.post(json)
    end
  end
end
