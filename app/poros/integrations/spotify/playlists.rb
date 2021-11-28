module Spotify
  module Playlists
    extend ActiveSupport::Concern

    def playlists
      get("#{self.class::SPOTIFY_URL}/me/playlists")
    end

    def playlist(playlist_id)
      get("#{self.class::SPOTIFY_URL}/playlists/#{playlist_id}")
    end

    def playlist_cover_art(playlist_id)
      get("#{self.class::SPOTIFY_URL}/playlists/#{playlist_id}/images")
    end

    def playlist_tracks(playlist_id)
      fields = 'items(track(id,uri,name,artists,duration_ms,album(id,name,images))),description,id,images'
      get("#{self.class::SPOTIFY_URL}/playlists/#{playlist_id}/tracks?fields=#{fields}")
    end
  end
end
