module Mopidy
  module Library
    def self.search_tracks(keyword)
      results = search(keyword)
      return [] if results.nil?
      results['tracks']
    end

    def self.get_track(uri)
      json = Mopidy.format_json(1, 'core.library.lookup', 'uri': uri)
      response = Mopidy.post(json)
      response.first
    end

    private

    def self.search(keyword)
      json = Mopidy.format_json(1, 'core.library.search', [{ 'any': keyword }])
      Mopidy.post(json).first
    end

    def self.parse_search_response(response)
      result = response.parsed_response['result']
      result.first unless result.nil?
    end
  end
end
