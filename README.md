# Mopidy

A lightweight wrapper around the Mopidy music server API.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mopidy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mopidy

## Usage

The gem is divided into modules that reflect the controllers in the [Mopidy core API](https://docs.mopidy.com/en/latest/api/core).
Currently, the supported modules are `Library`, `Playback`, `Playlist`, and `Tracklist`.

### Configuration

To configure the url that the gem makes requests to:
```ruby
Mopidy.configure do |config|
  config.mopidy_url = 'http://localhost:6680/mopidy/rpc' # This is the default
end
```

### Tracklist

This is the module that interfaces with [Mopidy's tracklist controller](https://docs.mopidy.com/en/latest/api/core/#tracklist-controller)

To get the tracks in the tracklist:
```ruby
Mopidy::Tracklist.tracks
```

To get the index of the currently playing track:
```ruby
Mopidy::Tracklist.index
```

To get the tracks in the tracklist as `TLTRack`s
```ruby
Mopidy::Tracklist.tl_tracks
```

To add a track to the tracklist:
```ruby
Mopidy::Tracklist.add(uri: 'example-track-uri')
```

To get the length of the tracklist:
```ruby
Mopidy::Tracklist.length
```

To clear the tracks from the tracklist:
```ruby
Mopidy::Tracklist.clear
```

### Library

This is the module that interfaces with [Mopidy's Library controller](https://docs.mopidy.com/en/latest/api/core/#library-controller)

To search for tracks, artists, playlists, and albums using a keyword:
```ruby
Mopidy::Library.search('queen')
```

To search for tracks by artist, album, or track:
```ruby
Mopidy::Library.search_tracks('bicycle')
```

To lookup a track by it's uri:

```ruby
Mopidy::Library.lookup('example-uri')
```

### Playlist

This is the module that interfaces with [Mopidy's Playlist controller](https://docs.mopidy.com/en/latest/api/core/#playlist-controller)

To get a list of playlists:
```ruby
Mopidy::Playlist.as_list
```

To lookup a playlist by it's uri
```ruby
Mopidy::Playlist.lookup('playlist-uri')
```

### Playback

This is the module that interfaces with [Mopidy's Playback controller](https://docs.mopidy.com/en/latest/api/core/#playlist-controller)

To play:
```ruby
Mopidy::Playlist.play
```

To pause:
```ruby
Mopidy::Playlist.pause
```

To resume:
```ruby
Mopidy::Playlist.resume
```

To stop:
```ruby
Mopidy::Playlist.stop
```

To get the playback state:
```ruby
Mopidy::Playlist.state
```

To get the current time position:
```ruby
Mopidy::Playlist.time_position
```

To seek to a time position:
```ruby
time_position = 1000 # Time position in milliseconds
Mopidy::Playlist.seek(time_position)
```

To get the currently playing track:
```ruby
Mopidy::Playlist.current_track
```

To skip to the next track:
```ruby
Mopidy::Playlist.next
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/khisakuni/mopidy.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
