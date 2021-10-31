module Spotify
  class Client
    CLIENT_SECRET = 'ddd04fa7c1b746d18d4c2cf707604dec'.freeze
    CLIENT_ID = '9d48abfbbf194adc9051e1b82b0ecdb0'.freeze
    REDIRECT_URI = 'http://localhost:3001/spotify_login'.freeze

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
