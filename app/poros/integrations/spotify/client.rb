module Spotify
  class Client
    CLIENT_SECRET = 'ddd04fa7c1b746d18d4c2cf707604dec'.freeze
    CLIENT_ID = '9d48abfbbf194adc9051e1b82b0ecdb0'.freeze
    REDIRECT_URI = 'http://localhost:3001/spotify_login'.freeze

    SPOTIFY_URL = 'https://api.spotify.com/v1/'.freeze

    attr_reader :access_token

    def initialize(access_token)
      @access_token = access_token
    end

    def login
      "https://accounts.spotify.com/authorize?client_id=#{CLIENT_ID}&response_type=code&redirect_uri=#{REDIRECT_URI}&scope=user-read-private%20user-read-email&state=34fFs29kd09"
    end

    def playlists
      Typhoeus.get("#{SPOTIFY_URL}/me/playlists",
                   headers: {
                     Authorization: "Bearer #{access_token}",
                     'Content-Type' => 'application/json'
                   })
    end

    def authorize
      response = Typhoeus.post('https://accounts.spotify.com/api/token',
                               {
                                 body: {
                                   grant_type: 'authorization_code',
                                   code: access_token,
                                   redirect_uri: REDIRECT_URI,
                                   client_id: CLIENT_ID,
                                   client_secret: CLIENT_SECRET
                                 },
                                 headers: {
                                   'Content-Type' => 'application/x-www-form-urlencoded'
                                 }
                               })
      return response unless response.success?
      
      JSON.parse(response.body).access_token
    end
  end
end
