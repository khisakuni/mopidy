require 'mopidy/response'

module Mopidy
  module Library

    def self.search_tracks(keyword)
      res = search(keyword)
      tracks = parse_search_response(res, 'tracks')
      format_response(tracks, res.status)
    end

    def self.get_track(uri)
      json = Mopidy.format_json(1, 'core.library.lookup', 'uri': uri)
      res = Mopidy.post(json)
      res.body.empty? ? res : format_response(res.body.first, res.status)
    end

    private

    def self.search(keyword)
      json = Mopidy.format_json(1, 'core.library.search', [{ 'any': keyword }])
      Mopidy.post(json)
    end

    def self.parse_search_response(response, type)
      data = response.body.first[type]
    end

    def self.format_response(data, status_code)
      new_response = OpenStruct.new(
        parsed_response: { 'result' => data },
        code: status_code
      )
      Mopidy::Response.new(new_response)
    end
  end
end
