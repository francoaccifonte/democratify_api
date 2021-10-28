module Integrations
  CLIENTS = {
    'spotify' => Spotify::Client,
    'apple' => 'Apple Music',
    'google' => 'Google Play Music',
    'youtube' => 'YouTube',
    'soundcloud' => 'SoundCloud',
    'tidal' => 'Tidal',
    'deezer' => 'Deezer',
    'amazon' => 'Amazon Music'
  }.freeze
end
