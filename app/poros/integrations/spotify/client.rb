module Spotify
  class Client
    CLIENT_SECRET = ENV['SPOTIFY_SECRET'].freeze
    CLIENT_ID = ENV['SPOTIFY_CLIENT_ID'].freeze
    REDIRECT_URI = ENV['SPOTIFY_REDIRECT_URL'].freeze

    SPOTIFY_URL = 'https://api.spotify.com/v1'.freeze

    attr_accessor :access_token, :login_token, :refresh_token

    def initialize(login_token: nil, access_token: nil, refresh_token: nil)
      @access_token = access_token
      @login_token = login_token
      @refresh_token = refresh_token
    end

    def playlists
      response = Typhoeus.get("#{SPOTIFY_URL}/me/playlists",
                              headers: {
                                Authorization: "Bearer #{access_token}",
                                'Content-Type' => 'application/json'
                              })
      JSON.parse(response.body, symbolize_names: true)
    end

    def playlist(playlist_id)
      response = Typhoeus.get(
        "#{SPOTIFY_URL}/playlists/#{playlist_id}",
        headers: {
          Authorization: "Bearer #{access_token}",
          'Content-Type' => 'application/json'
        }
      )
      JSON.parse(response.body, symbolize_names: true)
    end

    def playlist_tracks(playlist_id)
      fields = 'items(track(id,name,artists,duration_ms,album(id,name,images))),description,id,images'
      response = Typhoeus.get(
        "#{SPOTIFY_URL}/playlists/#{playlist_id}/tracks?fields=#{fields}",
        # "#{SPOTIFY_URL}/playlists/#{playlist_id}/tracks",
        headers: {
          Authorization: "Bearer #{access_token}",
          'Content-Type' => 'application/json'
        }
      )
      JSON.parse(response.body, symbolize_names: true)
    end

    def authorize
      response = Typhoeus.post(
        'https://accounts.spotify.com/api/token',
        {
          body: {
            grant_type: 'authorization_code',
            code: login_token,
            redirect_uri: REDIRECT_URI,
            client_id: CLIENT_ID,
            client_secret: CLIENT_SECRET
          },
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded'
          }
        }
      )
      JSON.parse(response.body, symbolize_names: true)
    end

    def user
      response = Typhoeus.get("#{SPOTIFY_URL}/me",
                              headers: {
                                Authorization: "Bearer #{access_token}",
                                'Content-Type' => 'application/json'
                              })
      JSON.parse response.body, symbolize_names: true
    end

    def refresh_access_token!
      response = Typhoeus.post(
        'https://accounts.spotify.com/api/token',
        {
          body: {
            grant_type: 'refresh_token',
            refresh_token: refresh_token,
            client_id: CLIENT_ID
            # client_secret: CLIENT_SECRET
          },
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded',
            Authorization: "Basic #{Base64.strict_encode64("#{CLIENT_ID}:#{CLIENT_SECRET}")}"
          }
        }
      )
      JSON.parse(response.body, symbolize_names: true)
    end
  end
end
